local status, tokyonight = pcall(require, "tokyonight")
if (not status) then return end


tokyonight.setup({
	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	transparent = true,
})

vim.cmd [[colorscheme tokyonight]]
