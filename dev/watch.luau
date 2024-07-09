local watch = require("../watch")

watch.directory({ "dev" }, function()
	print("changed")
end)
