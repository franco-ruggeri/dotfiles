return {
  "lervag/vimtex",
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_latexmk = { out_dir = "build" }
  end,
}
