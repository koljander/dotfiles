
function colorMyPencils(color)
	color = color or "gruber-darker"
	vim.cmd.colorscheme(color);

    --This popped up with colorscheme tokyo, was not nesscary on gruber
    --vim.cmd('hi SignColumn bg=none')

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" });
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" });

end

colorMyPencils()
