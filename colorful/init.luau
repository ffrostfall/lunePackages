local ANSI_16 = "%c[%dm"

local function createStylerFunction(opener: number, closer: number)
	local open = string.format(ANSI_16, 27, opener)
	local close = string.format(ANSI_16, 27, closer)

	return function(text: string)
		return `{open}{text}{close}`
	end
end

local function combineStyles(styleArray: { (text: string) -> string })
	return function(text: string)
		local result = text

		for _, style in styleArray do
			result = style(result)
		end

		return result
	end
end

return {
	combineStyles = combineStyles,

	modifier = {
		reset = createStylerFunction(0, 0),
		bold = createStylerFunction(1, 22),
		dim = createStylerFunction(2, 22),
		italic = createStylerFunction(3, 23),
		underline = createStylerFunction(4, 24),
		overline = createStylerFunction(53, 55),
		inverse = createStylerFunction(7, 27),
		hidden = createStylerFunction(8, 28),
		strikethrough = createStylerFunction(9, 29),
	},

	color = {
		black = createStylerFunction(30, 39),
		red = createStylerFunction(31, 39),
		green = createStylerFunction(32, 39),
		yellow = createStylerFunction(33, 39),
		blue = createStylerFunction(34, 39),
		magenta = createStylerFunction(35, 39),
		cyan = createStylerFunction(36, 39),
		white = createStylerFunction(37, 39),
		gray = createStylerFunction(90, 39),
		grey = createStylerFunction(90, 39),

		blackBright = createStylerFunction(90, 39),
		redBright = createStylerFunction(91, 39),
		greenBright = createStylerFunction(92, 39),
		yellowBright = createStylerFunction(93, 39),
		blueBright = createStylerFunction(94, 39),
		magentaBright = createStylerFunction(95, 39),
		cyanBright = createStylerFunction(96, 39),
		whiteBright = createStylerFunction(97, 39),
	},
}
