local spawnProcess = require("../spawnProcess")

local darklua = {}

function darklua.build(projectDirectory: string, targetDirectory: string, configFileName: string, watch: boolean)
	local parameters = {
		"process",
		"--config",
		configFileName,
		projectDirectory,
		targetDirectory,
	}

	if watch then
		table.insert(parameters, "--watch")
	end

	spawnProcess("darklua", parameters)
end

return darklua
