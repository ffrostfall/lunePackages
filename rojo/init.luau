local spawnProcess = require("../spawnProcess")

local rojo = {}

function rojo.serve(projectFile: string): thread
	return spawnProcess("rojo", { "serve", projectFile })
end

function rojo.sourcemap(projectFile: string, outputFile: string, watch: boolean): thread
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

	return spawnProcess("rojo", parameters)
end

function rojo.build(projectFile: string, output: string): thread
	return spawnProcess("rojo", { "build", projectFile, "--output", output })
end

return rojo
