-- NOTE: creates space when opening html tag. eg:
--<div>
--  |
--</div>
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = true,
}
