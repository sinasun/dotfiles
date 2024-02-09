local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

null_ls.setup {
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.rustfmt,
		--null_ls.builtins.diagnostics.eslint_d.with({
		--		diagnostics_format = '[eslint] #{m}\n(#{c})'
		--	}),
		null_ls.builtins.diagnostics.fish
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end
}

-- local status2, eslint = pcall(require, "eslint")
-- if (not status2) then return end
--
-- eslint.setup({
-- 	bin = 'eslint_d', -- or `eslint_d`
-- 	code_actions = {
-- 		enable = true,
-- 		apply_on_save = {
-- 			enable = true,
-- 			types = { "directive", "problem", "suggestion", "layout" },
-- 		},
-- 		disable_rule_comment = {
-- 			enable = true,
-- 			location = "separate_line", -- or `same_line`
-- 		},
-- 	},
-- 	diagnostics = {
-- 		enable = true,
-- 		report_unused_disable_directives = false,
-- 		run_on = "type", -- or `save`
-- 	},
-- })

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
vim.api.nvim_create_user_command(
	'DisableLspFormatting',
	function()
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
	end,
	{ nargs = 0 }
)
