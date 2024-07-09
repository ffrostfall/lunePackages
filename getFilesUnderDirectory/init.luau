local fs = require("@lune/fs")

local function read(currentDir: string): { string }
	local paths: { string } = {}

	local contents = fs.readDir(currentDir)
	if not contents then
		return {}
	end

	for _, filePath in contents do
		local path = currentDir .. "/" .. filePath

		if fs.isDir(path) then
			local subdirectoryContents = read(path)

			for _, element in subdirectoryContents do
				table.insert(paths, path .. "/" .. element)
			end
		else
			table.insert(paths, path)
		end
	end

	return paths
end

return read
