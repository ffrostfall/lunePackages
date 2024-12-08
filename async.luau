local task = require("@lune/task")

return function(thread: thread)
	while coroutine.status(thread) ~= "dead" do
		task.wait()
	end
end
