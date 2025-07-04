local utils = require("utils")

local function get_codecompanion_component()
	local M = require("lualine.component"):extend()

	local default_options = {
		icon = " ",
		spinner_symbols = {
			"⠋",
			"⠙",
			"⠹",
			"⠸",
			"⠼",
			"⠴",
			"⠦",
			"⠧",
			"⠇",
			"⠏",
		},
		done_symbol = "✓",
	}

	function M:init(options)
		M.super.init(self, options)

		self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)
		self.processing = false
		self.spinner_index = 1

		vim.api.nvim_create_autocmd("User", {
			pattern = "CodeCompanionRequest*",
			callback = function(request)
				if request.match == "CodeCompanionRequestStarted" then
					self.processing = true
				elseif request.match == "CodeCompanionRequestFinished" then
					self.processing = false
				end
			end,
		})
	end

	function M:update_status()
		if not package.loaded["codecompanion"] then
			return nil
		elseif self.processing then
			self.spinner_index = (self.spinner_index % #self.options.spinner_symbols) + 1
			return self.options.spinner_symbols[self.spinner_index]
		else
			return self.options.done_symbol
		end
	end

	return M
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- for icons
		-- "ravitemer/mcphub.nvim", -- for mcphub component
		"letieu/harpoon-lualine", -- for harpoon component
	},
	opts = {
		options = {
			globalstatus = true,
		},
		sections = {
			-- Add lsp_status to know which LSP clients are active.
			-- Remove fileformat and encoding to save space.
			lualine_x = {
				"lsp_status",
				"filetype",
			},
		},
		tabline = {
			lualine_a = { "tabs" },
			lualine_b = {
				{
					"harpoon2",
					icon = "󰀱 ",
					indicators = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
					active_indicators = { "[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]", "[8]", "[9]" },
				},
			},
			lualine_c = { "filename" },
		},
	},
	config = function(_, opts)
		opts.tabline.lualine_x = {
			{ utils.get_lualine_component_lazy("mcphub", "mcphub.extensions.lualine") },
			{ get_codecompanion_component() },
		}
		require("lualine").setup(opts)
	end,
}
