local process = require("@lune/process")

local rojo = {}

function rojo.serve(projectFile: string)
	process.spawn("rojo", { "serve", projectFile })
end

function rojo.sourcemap(projectFile: string, outputFile: string, watch: boolean)
	local parameters = {
		"sourcemap",
		projectFile,
		"-o",
		outputFile,
		"--include-non-scripts",
	}

	if watch then
		table.insert(parameters, "--watch")
	end

	process.spawn("rojo", parameters)
end

function rojo.build(projectFile: string)
	process.spawn("rojo", { "build", projectFile })
end

return rojo
