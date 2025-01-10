return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local lint = require("lint")

		local function has_deno_config()
			local root_dir = vim.fn.getcwd()
			local deno_config_path = root_dir .. "/deno.json"
			return vim.fn.filereadable(deno_config_path) == 1
		end

		lint.linters_by_ft = {
			javascript = { has_deno_config() and "deno" or "eslint_d" },
			typescript = { has_deno_config() and "deno" or "eslint_d" },
			javascriptreact = { has_deno_config() and "deno" or "eslint_d" },
			typescriptreact = { has_deno_config() and "deno" or "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
