return {
	"echasnovski/mini.surround",
	opts = {
		custom_surroundings = nil,
		highlight_duration = 500,
		mappings = {
			add = "sa",
			delete = "sd",
			find = "sf",
			find_left = "sF",
			highlight = "sh",
			replace = "sr",
			update_n_lines = "sn", -- Update `n_lines`

			suffix_last = "l",     -- Suffix to search with "prev" method
			suffix_next = "n",     -- Suffix to search with "next" method
		},
		n_lines = 20,
		respect_selection_type = false,
		search_method = "cover",
		silent = false,
	}
}
