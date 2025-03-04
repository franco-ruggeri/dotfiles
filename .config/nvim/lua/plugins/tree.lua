return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "[e]xplore toggle tree" },
    { "<leader>eb", "<cmd>NvimTreeFindFile<cr>", desc = "[e]xplore find [b]uffer in tree" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<cr>", desc = "[e]xplore [c]ollapse tree" },
  },
  opts = {},
}
