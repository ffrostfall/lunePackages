local converter = require("converter")
local lexer = require("lexer")
local parser = require("parser")
local prep = require("prep")

local function main(source: string)
	local preppedSource = prep(source)
	local lexemes = lexer(preppedSource)
	local parsed = parser(lexemes)
	local converted = converter(parsed)

	return converted
end

return main
