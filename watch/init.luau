local fs = require("@lune/fs")
local task = require("@lune/task")
local getFilesUnderDirectory = require("../getFilesUnderDirectory")

local function watchPaths(paths: { string }, callback: () -> ())
	local lastModified = {}
	for _, path in paths do
		lastModified[path] = fs.metadata(path).modifiedAt
	end

	while true do
		local changed = false

		for path, modified in lastModified do
			local newModified = fs.metadata(path).modifiedAt
			if newModified ~= modified then
				lastModified[path] = newModified
				changed = true
				break
			end
		end

		if changed then
			task.spawn(callback)
		end

		task.wait(1)
	end
end

local watch = {}

function watch.directory(directories: { string }, onChanged: () -> ()): thread
	local paths = {}

	for _, directoryPath in directories do
		for _, filePath in getFilesUnderDirectory(directoryPath) do
			table.insert(paths, filePath)
		end
	end

	return task.spawn(watchPaths, paths, onChanged)
end

function watch.file(fileName: string, callback: () -> ())
	return task.spawn(function()
		local lastModified = fs.metadata(fileName).modifiedAt

		while true do
			local newModified = fs.metadata(fileName).modifiedAt
			if newModified ~= lastModified then
				task.spawn(callback)

				lastModified = newModified
			end

			task.wait(1)
		end
	end)
end

return watch
