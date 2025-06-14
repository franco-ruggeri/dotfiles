return {
	"Exafunction/codeium.nvim",
	enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "InsertEnter",
	build = ":Codeium Auth",
	opts = {
		api = {
			host = vim.env.CODEIUM_HOST,
		},
		enterprise_mode = true,
		enable_chat = true,
		enable_cmp_source = false,
		virtual_text = {
			enabled = true,
			key_bindings = {
				accept = "<M-l>",
			},
		},
	},
	keys = {
		{ "<leader>a", "<Cmd>Codeium Chat<CR>", desc = "[A]I open" },
	},
}
