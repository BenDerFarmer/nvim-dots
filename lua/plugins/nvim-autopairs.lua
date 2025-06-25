return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	config = function()
		-- import nvim-autopairs
		local autopairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")

		-- configure autopairs
		autopairs.setup({
			check_ts = true, -- enable treesitter
			ts_config = {
				lua = { "string" }, -- don't add pairs in lua string treesitter nodes
				javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
				java = false, -- don't check treesitter on java
			},
		})

		-- autopairs.add_rules({
		-- 	Rule('"', "'")
		-- 		:with_pair(function(opts)
		-- 			-- Ensure pairing only happens in valid contexts
		-- 			local line = opts.line
		-- 			local col = opts.col
		--
		-- 			-- Check if the character before the cursor is not a closing quote
		-- 			local prev_char = line:sub(col - 1, col - 1)
		-- 			if prev_char == "'" then
		-- 				return false
		-- 			end
		--
		-- 			-- Additional safeguard: disallow pairing if inside a word
		-- 			local next_char = line:sub(col, col)
		-- 			return not (next_char:match("[%w_]"))
		-- 		end)
		-- 		:with_move(function(opts)
		-- 			-- Ensure the cursor moves only if the next character is the expected closing quote
		-- 			return opts.next_char == "'"
		-- 		end)
		-- 		:with_del(function(opts)
		-- 			-- Only delete the pair if it matches `"string'` context
		-- 			local line = opts.line
		-- 			local col = opts.col
		-- 			local prev_char = line:sub(col - 1, col - 1)
		-- 			local next_char = line:sub(col, col)
		--
		-- 			return prev_char == '"' and next_char == "'"
		-- 		end)
		-- 		:use_key('"'), -- Trigger the rule when typing double-quote
		-- })

		-- import nvim-autopairs completion functionality
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		-- import nvim-cmp plugin (completions plugin)
		local cmp = require("cmp")

		-- make autopairs and completion work together
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
