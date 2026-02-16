return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"scss",
			"css",
			"javascript",
			"html",
		})
	end,
}
