local process = require("@lune/process")
local task = require("@lune/task")

return function(processName: string, parameters: { string }): thread
	return task.spawn(process.spawn, processName, parameters, {
		stdio = "forward" :: "forward",
	})
end
