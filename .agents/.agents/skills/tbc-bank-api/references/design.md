# TBC Design Guidelines

Design specifications from `developers.tbcbank.ge/docs/design` for TBC-branded payment UI components.

---

## Colors

| Name | Hex | Usage |
|------|-----|-------|
| TBC Blue | `#00AEEF` | Primary actions, links, active states |
| Dark Blue | `#0C2B43` | Text headings, dark backgrounds |
| Error Red | `#eb4949` | Validation errors, destructive actions |
| Gray 1 | `#F5F5F5` | Page backgrounds, disabled inputs |
| Gray 2 | `#E0E0E0` | Borders, dividers |
| Gray 3 | `#9E9E9E` | Placeholder text, secondary labels |
| Gray 4 | `#616161` | Body text |
| White | `#FFFFFF` | Card backgrounds, button text on dark |

---

## Typography

**Font family**: TBC Sailec Regular

Load from TBC's CDN:

```css
@font-face {
  font-family: 'TBC Sailec';
  src: url('https://openapiportalobjects.tbcbank.ge/fonts/TBCSailecRegular.woff2') format('woff2'),
       url('https://openapiportalobjects.tbcbank.ge/fonts/TBCSailecRegular.woff') format('woff');
  font-weight: 400;
  font-style: normal;
}
```

---

## Buttons

Four button variants available:

### Blue (Primary)

```css
.tbcButton.tbcButtonBlue {
  background-color: #00AEEF;
  color: #FFFFFF;
  border: none;
  border-radius: 4px;
  padding: 12px 24px;
  font-family: 'TBC Sailec', sans-serif;
  font-size: 14px;
  cursor: pointer;
}

.tbcButton.tbcButtonBlue:hover {
  background-color: #0099D6;
}
```

### Light (Secondary)

```css
.tbcButton.tbcButtonLight {
  background-color: #FFFFFF;
  color: #00AEEF;
  border: 1px solid #00AEEF;
  border-radius: 4px;
  padding: 12px 24px;
  font-family: 'TBC Sailec', sans-serif;
  font-size: 14px;
  cursor: pointer;
}

.tbcButton.tbcButtonLight:hover {
  background-color: #F0FAFF;
}
```

### Light Monochrome

```css
.tbcButton.tbcButtonLightMono {
  background-color: #FFFFFF;
  color: #0C2B43;
  border: 1px solid #E0E0E0;
  border-radius: 4px;
  padding: 12px 24px;
  font-family: 'TBC Sailec', sans-serif;
  font-size: 14px;
  cursor: pointer;
}

.tbcButton.tbcButtonLightMono:hover {
  background-color: #F5F5F5;
}
```

### Dark Monochrome

```css
.tbcButton.tbcButtonDarkMono {
  background-color: #0C2B43;
  color: #FFFFFF;
  border: none;
  border-radius: 4px;
  padding: 12px 24px;
  font-family: 'TBC Sailec', sans-serif;
  font-size: 14px;
  cursor: pointer;
}

.tbcButton.tbcButtonDarkMono:hover {
  background-color: #0A2235;
}
```

---

## Text Input

```css
.tbcInput {
  width: 300px;
  height: 50px;
  border: 1px solid #E0E0E0;
  border-radius: 4px;
  padding: 16px 12px 4px;
  font-family: 'TBC Sailec', sans-serif;
  font-size: 14px;
  color: #0C2B43;
  position: relative;
}

.tbcInput:focus {
  border-color: #00AEEF;
  outline: none;
}

.tbcInput.error {
  border-color: #eb4949;
}

/* Animated floating label */
.tbcInput-label {
  position: absolute;
  left: 12px;
  top: 16px;
  font-size: 14px;
  color: #9E9E9E;
  transition: all 0.2s ease;
  pointer-events: none;
}

.tbcInput:focus + .tbcInput-label,
.tbcInput.filled + .tbcInput-label {
  top: 4px;
  font-size: 10px;
  color: #00AEEF;
}

.tbcInput.error + .tbcInput-label {
  color: #eb4949;
}

/* Error message */
.tbcInput-error {
  font-size: 12px;
  color: #eb4949;
  margin-top: 4px;
}
```

---

## Card Component

```css
.tbcCard {
  background: #FFFFFF;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
  transition: box-shadow 0.2s ease;
}

.tbcCard:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}
```

---

## Layout

| Property | Value |
|----------|-------|
| Container max-width | `1140px` |
| Container padding | `0 15px` |
| Container margin | `0 auto` |

### Responsive Breakpoints

| Breakpoint | Max-width | Usage |
|------------|-----------|-------|
| Desktop | `>990px` | Full layout |
| Tablet | `990px` | Collapse side panels |
| Mobile | `768px` | Stack columns |
| Small mobile | `770px` | Compact spacing |

```css
.tbcContainer {
  max-width: 1140px;
  margin: 0 auto;
  padding: 0 15px;
}

@media (max-width: 990px) {
  .tbcContainer { padding: 0 20px; }
}

@media (max-width: 768px) {
  .tbcContainer { padding: 0 16px; }
}
```

---

## Logo

| Placement | Dimensions |
|-----------|------------|
| Header logo | `45px x 40px` |
| Button icon (SVG) | `24px x 24px` |

Use the TBC logo assets provided through the developer portal. Do not modify colors or proportions.
