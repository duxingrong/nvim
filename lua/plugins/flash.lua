return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  -- stylua: ignore
  keys = {
    { "ss",    mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
