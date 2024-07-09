export type TokenKind =
	"STRING"
	| "NULL"
	| "IGNORE"
	| "NUMBER"
	| "NEWLINE"
	| "EQUATES"
	| "COMMENT"
	| "INVALID"
	| "BOOLEAN"
	| "SEPARATOR"
	| "ARRAY_OPEN"
	| "IDENTIFIER"
	| "ARRAY_CLOSE"
	| "STRUCT_OPEN"
	| "STRUCT_CLOSE"

export type Token = {
	kind: TokenKind,
	value: string,
}

local function tokenize(character: string): Token
	local kind: TokenKind = if character == "\n"
		then "IGNORE"
		elseif character == ";" then "IGNORE"
		elseif character == "," then "IGNORE"
		elseif character == '"' then "STRING"
		elseif character == "'" then "STRING"
		elseif character == " " then "IGNORE"
		elseif character == ":" then "EQUATES"
		elseif character == "/" then "COMMENT"
		elseif character == "\t" then "IGNORE"
		elseif character == "[" then "ARRAY_OPEN"
		elseif character == "{" then "STRUCT_OPEN"
		elseif character == "]" then "ARRAY_CLOSE"
		elseif character == "}" then "STRUCT_CLOSE"
		else "INVALID"

	return {
		kind = kind,
		value = character,
	}
end

local function lexer(source: string): { Token }
	local characters = string.split(source, "")
	local tokens: { Token } = {}
	local cursor = 1

	while cursor <= #characters do
		local char = characters[cursor]
		cursor += 1

		if char == "\\" then
			cursor += 1
		end

		if char == "/" then
			local nextChar = characters[cursor]

			if nextChar and nextChar == "/" then
				while true do
					if characters[cursor] and characters[cursor] == "\n" then
						break
					end

					cursor += 1
				end
			else
				error("syntaxxxx")
			end

			continue
		end

		local alphanumerical = string.match(char, "%w") ~= nil
		if alphanumerical then
			local escaped = false
			local token: Token = {
				kind = "IDENTIFIER",
				value = char,
			}

			while not escaped do
				local currentCharacter = characters[cursor]
				if not string.match(currentCharacter, "[%w%.]") then
					escaped = true
					break
				elseif not currentCharacter then
					error("what the carp")
				else
					token.value ..= currentCharacter
				end

				cursor += 1
			end

			if string.match(token.value, "[%d%.]+") then
				token.kind = "NUMBER"
			end

			if token.value == "null" then
				token.kind = "NULL"
			elseif token.value == "true" or token.value == "false" then
				token.kind = "BOOLEAN"
			end

			table.insert(tokens, token)
			continue
		end

		local token = tokenize(char)
		if token.kind == "IGNORE" then
			continue
		end

		if token.kind == "STRING" then
			local escaped = false
			local escapeCharacter = char
			local value = ""

			while not escaped do
				local currentCharacter = characters[cursor]
				if currentCharacter == "\n" then
					error(cursor)
				elseif currentCharacter == escapeCharacter then
					escaped = true
				elseif not currentCharacter then
					error("what the carp")
				else
					value ..= currentCharacter
				end

				cursor += 1
			end

			token.value = value
		end

		table.insert(tokens, token)
	end

	return tokens
end

return lexer
