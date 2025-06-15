local function is_installed(package)
	local mason_registry = require("mason-registry")
	return mason_registry.is_installed(package)
end

local function start(args)
	-- Search plugins
	local bundles = {}
	if is_installed("java-debug-adapter") then
		table.insert(
			bundles,
			vim.fn.glob(
				vim.env.MASON .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin*.jar"
			)
		)
	end
	if is_installed("java-test") then
		table.insert(
			bundles,
			vim.fn.glob(vim.env.MASON .. "/packages/java-test/extension/server/com.microsoft.java.test.plugin*.jar")
		)
	end

	-- Start jdtls language server (with plugins)
	require("jdtls").start_or_attach({
		cmd = { vim.env.MASON .. "/packages/jdtls/bin/jdtls" },
		root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
		init_options = { bundles = bundles },
	})

	-- TODO: for some reason, the java adapter doesn't get registered
	-- TODO: do I really need to setup main class configs every debug run? maybe not... is it done automatically on the above setup?
	-- Update configuration on debug continue
	local function set_keymap(keymap)
		vim.keymap.set("n", keymap, function()
			require("jdtls.dap").setup_dap_main_class_configs()
			for k, _ in pairs(require("dap").adapters) do
				print(k)
			end
			require("dap").continue()
		end, { desc = "[d]ebug [r]un main class", buffer = args.buf })
	end
	set_keymap("<Leader>dr")
	set_keymap("F5")
end

return {
	"mfussenegger/nvim-jdtls",
	dependencies = {
		"williamboman/mason.nvim", -- package manager for installing jdtls
		"mfussenegger/nvim-dap", -- for debugging support
	},
	config = function()
		if is_installed("jdtls") then
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = start,
			})
		end
	end,
}
