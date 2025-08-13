scriptencoding utf-8


lua << EOF
vim.notify = require("notify")

vim.notify.setup({
	background_colour = "NotifyBackground",
	fps = 60,
	icons = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = ""
	},
	level = 2,
	minimum_width = 50,
	render = "compact",
	stages = "static",
	time_formats = {
		notification = "%T",
		notification_history = "%FT%T"
	},
	timeout = 1000,
	top_down = true
})
EOF
