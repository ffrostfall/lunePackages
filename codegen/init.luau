export type LuauExpr = string
export type LuauType = string
export type LuauStmt = string

local codegen = {}

function codegen.numberType(): LuauType
	return "number"
end

function codegen.intersectionType(types: { LuauType }): LuauType
	return table.concat(types, "&")
end

function codegen.unionType(types: { LuauType }): LuauType
	return table.concat(types, "|")
end

function codegen.stringType(): LuauType
	return "string"
end

function codegen.booleanType(): LuauType
	return "boolean"
end

function codegen.optionalType(containedType: LuauType): LuauType
	return `{containedType}?`
end

function codegen.nilType(): LuauType
	return "nil"
end

function codegen.parenType(containedType: LuauType): LuauType
	return `({containedType})`
end

function codegen.arrayType(containedType: LuauType): LuauType
	return `{containedType}`
end

function codegen.namedType(name: string): LuauType
	return name
end

function codegen.defineTypeStmt(name: string, value: LuauType): LuauStmt
	return `type {name} = {value}`
end

function codegen.defineExportedTypeStmt(name: string, value: LuauType): LuauStmt
	return `export type {name} = {value}`
end

function codegen.returnStmt(value: LuauExpr): LuauStmt
	return `return {value}`
end

function codegen.exprArray(elements: { LuauExpr }): LuauExpr
	return `\{{table.concat(elements, ",\n")}\}`
end

function codegen.exprKeyDictionary(dict: { [LuauExpr]: LuauExpr })
	local lines = {}

	for key, value in dict do
		table.insert(lines, `[{key}] = {value}`)
	end

	return `\{{table.concat(lines, ", \n")}\}`
end

function codegen.exprIdentifierDictionary(dict: { [string]: LuauExpr })
	local lines = {}

	for key, value in dict do
		table.insert(lines, `{key} = {value}`)
	end

	return `\{{table.concat(lines, ",\n")}\}`
end

function codegen.exprString(value: string): LuauExpr
	return `"{value}"`
end

function codegen.exprNumber(value: number): LuauExpr
	return `{value}`
end

function codegen.exprBoolean(value: boolean): LuauExpr
	return if value then "true" else "false"
end

function codegen.exprNil(): LuauExpr
	return "nil"
end

function codegen.dotIndex(identifier: string, value: LuauExpr): LuauExpr
	return `{identifier}.{value}`
end

function codegen.index(index: LuauExpr, value: LuauExpr): LuauExpr
	return `{index}[{value}]`
end

function codegen.call(value: LuauExpr, args: { LuauExpr }): LuauExpr
	return `{value}({table.concat(args, ", ")})`
end

function codegen.methodCall(identifier: string, method: string, args: { LuauExpr }): LuauExpr
	return `{identifier}:{method}({table.concat(args, ", ")})`
end

return codegen
