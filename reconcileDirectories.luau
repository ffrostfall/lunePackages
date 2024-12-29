local fs = require("@lune/fs")

return function(paths: { string })
	for _, path in paths do
		if not fs.isDir(path) then fs.writeDir(path) end
	end
end
