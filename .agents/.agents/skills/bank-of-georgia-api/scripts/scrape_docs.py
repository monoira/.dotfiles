#!/usr/bin/env python3
"""
BOG API Documentation Scraper

Fetches latest documentation from Bank of Georgia's developer portals
and compares against current reference files to detect updates.

Usage:
    python scrape_docs.py                    # Scrape and show diff summary
    python scrape_docs.py --update           # Scrape and update reference files
    python scrape_docs.py --output DIR       # Save scraped docs to custom directory
    python scrape_docs.py --firecrawl        # Use Firecrawl API (requires FIRECRAWL_API_KEY)

Requirements:
    pip install requests beautifulsoup4
    Optional: pip install firecrawl-py  (for --firecrawl mode)
"""

import argparse
import hashlib
import json
import os
import re
import sys
from datetime import datetime
from pathlib import Path

try:
    import requests
    from bs4 import BeautifulSoup
except ImportError:
    print("Error: Install dependencies first:")
    print("  pip install requests beautifulsoup4")
    sys.exit(1)

SCRIPT_DIR = Path(__file__).parent
SKILL_DIR = SCRIPT_DIR.parent
REFERENCES_DIR = SKILL_DIR / "references"

# BOG documentation source URLs
BOG_SOURCES = {
    "payments": {
        "label": "iPay / Online Payments",
        "urls": [
            "https://api.bog.ge/docs/payments/introduction",
            "https://api.bog.ge/docs/payments/authentication",
            "https://api.bog.ge/docs/payments/create-order",
            "https://api.bog.ge/docs/payments/callback",
            "https://api.bog.ge/docs/payments/refund",
            "https://api.bog.ge/docs/payments/preauthorization",
        ],
        "reference_file": "ipay.md",
    },
    "installments": {
        "label": "Installment Loans",
        "urls": [
            "https://api.bog.ge/docs/installment/introduction",
            "https://api.bog.ge/docs/installment/authentication",
            "https://api.bog.ge/docs/installment/create-order",
            "https://api.bog.ge/docs/installment/callback",
        ],
        "reference_file": "installments.md",
    },
    "openbanking": {
        "label": "Open Banking / PSD2",
        "urls": [
            "https://api.bog.ge/docs/openbanking/introduction",
            "https://api.bog.ge/docs/openbanking/consents",
            "https://api.bog.ge/docs/openbanking/accounts",
            "https://api.bog.ge/docs/openbanking/payments",
        ],
        "reference_file": "openbanking.md",
    },
    "bogid": {
        "label": "BOG-ID (SSO)",
        "urls": [
            "https://api.bog.ge/docs/bogid/introduction",
            "https://api.bog.ge/docs/bogid/authentication",
            "https://api.bog.ge/docs/bogid/userinfo",
        ],
        "reference_file": "bogid.md",
    },
}

# Alternative scraping targets (publicly accessible pages)
BOG_PUBLIC_PAGES = [
    {"url": "https://api.bog.ge", "label": "Developer Portal Home"},
    {"url": "https://ipay.ge", "label": "iPay Portal"},
    {"url": "https://installment.bog.ge", "label": "Installment Portal"},
]


def fetch_page(url: str, timeout: int = 15) -> str | None:
    """Fetch a URL and return its text content."""
    headers = {
        "User-Agent": "Mozilla/5.0 (compatible; BOGDocScraper/1.0)",
        "Accept": "text/html,application/xhtml+xml,application/json",
    }
    try:
        resp = requests.get(url, headers=headers, timeout=timeout, allow_redirects=True)
        resp.raise_for_status()
        return resp.text
    except requests.RequestException as e:
        print(f"  ⚠️  Failed to fetch {url}: {e}")
        return None


def html_to_markdown(html: str) -> str:
    """Extract meaningful text content from HTML as rough markdown."""
    soup = BeautifulSoup(html, "html.parser")

    # Remove scripts, styles, navs
    for tag in soup(["script", "style", "nav", "footer", "header", "aside"]):
        tag.decompose()

    # Find main content area
    main = soup.find("main") or soup.find("article") or soup.find(class_=re.compile(r"content|docs|api"))
    if main:
        soup = main

    lines = []
    for el in soup.find_all(["h1", "h2", "h3", "h4", "p", "pre", "code", "li", "table", "tr", "td", "th"]):
        text = el.get_text(strip=True)
        if not text:
            continue
        if el.name == "h1":
            lines.append(f"\n# {text}\n")
        elif el.name == "h2":
            lines.append(f"\n## {text}\n")
        elif el.name == "h3":
            lines.append(f"\n### {text}\n")
        elif el.name == "h4":
            lines.append(f"\n#### {text}\n")
        elif el.name == "pre":
            code = el.get_text()
            lines.append(f"\n```\n{code}\n```\n")
        elif el.name == "li":
            lines.append(f"- {text}")
        elif el.name == "p":
            lines.append(f"\n{text}\n")

    return "\n".join(lines)


def fetch_with_firecrawl(url: str) -> str | None:
    """Fetch a URL using Firecrawl API for better JS rendering."""
    api_key = os.environ.get("FIRECRAWL_API_KEY")
    if not api_key:
        print("  ⚠️  FIRECRAWL_API_KEY not set, falling back to requests")
        return None

    try:
        from firecrawl import FirecrawlApp
        app = FirecrawlApp(api_key=api_key)
        result = app.scrape_url(url, params={"formats": ["markdown"]})
        return result.get("markdown", "")
    except ImportError:
        # Try direct API call
        try:
            resp = requests.post(
                "https://api.firecrawl.dev/v1/scrape",
                headers={"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"},
                json={"url": url, "formats": ["markdown"]},
                timeout=30,
            )
            resp.raise_for_status()
            data = resp.json()
            return data.get("data", {}).get("markdown", "")
        except Exception as e:
            print(f"  ⚠️  Firecrawl failed for {url}: {e}")
            return None


def content_hash(text: str) -> str:
    """Hash content for change detection."""
    normalized = re.sub(r"\s+", " ", text.strip().lower())
    return hashlib.md5(normalized.encode()).hexdigest()[:12]


def compare_with_reference(scraped: str, ref_path: Path) -> dict:
    """Compare scraped content with existing reference file."""
    if not ref_path.exists():
        return {"status": "new", "ref_path": str(ref_path)}

    existing = ref_path.read_text()
    existing_hash = content_hash(existing)
    scraped_hash = content_hash(scraped)

    if existing_hash == scraped_hash:
        return {"status": "unchanged", "hash": existing_hash}

    # Rough diff: count new lines not in existing
    existing_lines = set(existing.lower().split("\n"))
    scraped_lines = scraped.lower().split("\n")
    new_lines = [l for l in scraped_lines if l.strip() and l not in existing_lines]

    return {
        "status": "changed",
        "existing_hash": existing_hash,
        "scraped_hash": scraped_hash,
        "new_lines_count": len(new_lines),
        "sample_new_lines": new_lines[:5],
    }


def scrape_all(use_firecrawl: bool = False) -> dict:
    """Scrape all BOG documentation sources."""
    results = {}

    for key, source in BOG_SOURCES.items():
        print(f"\n▸ Scraping: {source['label']}...")
        all_content = []

        for url in source["urls"]:
            print(f"  Fetching {url}...")
            content = None

            if use_firecrawl:
                content = fetch_with_firecrawl(url)

            if not content:
                html = fetch_page(url)
                if html:
                    content = html_to_markdown(html)

            if content and len(content.strip()) > 50:
                all_content.append(f"<!-- Source: {url} -->\n{content}")
            else:
                print(f"  ⚠️  No meaningful content from {url}")

        if all_content:
            merged = "\n\n---\n\n".join(all_content)
            ref_path = REFERENCES_DIR / source["reference_file"]
            comparison = compare_with_reference(merged, ref_path)

            results[key] = {
                "label": source["label"],
                "urls_scraped": len(all_content),
                "urls_total": len(source["urls"]),
                "content_length": len(merged),
                "comparison": comparison,
                "content": merged,
            }
        else:
            results[key] = {
                "label": source["label"],
                "urls_scraped": 0,
                "urls_total": len(source["urls"]),
                "error": "No content retrieved",
            }

    # Also check public pages for accessibility
    print("\n▸ Checking public portal pages...")
    for page in BOG_PUBLIC_PAGES:
        html = fetch_page(page["url"])
        status = "accessible" if html and len(html) > 100 else "unreachable"
        print(f"  {page['label']}: {status}")

    return results


def print_report(results: dict):
    """Print a summary report of scraping results."""
    print("\n═══════════════════════════════════════════════════════")
    print("  BOG Documentation Scrape Report")
    print(f"  {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("═══════════════════════════════════════════════════════\n")

    for key, result in results.items():
        label = result["label"]
        if "error" in result:
            print(f"  ❌ {label}: {result['error']}")
            continue

        comp = result["comparison"]
        status = comp["status"]
        urls = f"{result['urls_scraped']}/{result['urls_total']} pages"

        if status == "unchanged":
            print(f"  ✅ {label}: No changes detected ({urls})")
        elif status == "new":
            print(f"  🆕 {label}: New content ({urls}, {result['content_length']} chars)")
        elif status == "changed":
            new_lines = comp["new_lines_count"]
            print(f"  🔄 {label}: Changes detected ({urls}, ~{new_lines} new lines)")
            if comp.get("sample_new_lines"):
                for line in comp["sample_new_lines"][:3]:
                    if line.strip():
                        print(f"      + {line.strip()[:80]}")


def save_scraped(results: dict, output_dir: Path):
    """Save scraped content to output directory."""
    output_dir.mkdir(parents=True, exist_ok=True)

    for key, result in results.items():
        if "content" in result:
            out_file = output_dir / f"{key}.md"
            out_file.write_text(result["content"])
            print(f"  Saved: {out_file}")

    # Save metadata
    meta = {
        "scraped_at": datetime.now().isoformat(),
        "sources": {k: {kk: vv for kk, vv in v.items() if kk != "content"} for k, v in results.items()},
    }
    meta_file = output_dir / "scrape_metadata.json"
    meta_file.write_text(json.dumps(meta, indent=2))
    print(f"  Saved: {meta_file}")


def main():
    parser = argparse.ArgumentParser(description="BOG API Documentation Scraper")
    parser.add_argument("--update", action="store_true", help="Update reference files with scraped content")
    parser.add_argument("--output", type=str, help="Save scraped docs to custom directory")
    parser.add_argument("--firecrawl", action="store_true", help="Use Firecrawl API for JS-rendered pages")
    parser.add_argument("--json", action="store_true", help="Output results as JSON")
    args = parser.parse_args()

    results = scrape_all(use_firecrawl=args.firecrawl)

    if args.json:
        clean = {k: {kk: vv for kk, vv in v.items() if kk != "content"} for k, v in results.items()}
        print(json.dumps(clean, indent=2))
    else:
        print_report(results)

    if args.output:
        output_dir = Path(args.output)
        print(f"\nSaving scraped content to {output_dir}...")
        save_scraped(results, output_dir)

    if args.update:
        print("\n⚠️  --update mode: Overwriting reference files is manual.")
        print("   Review scraped content first, then copy to references/")
        print("   Use --output to save scraped content for review.")


if __name__ == "__main__":
    main()
