local clappy = require("../clappy.luau")

local testCommand = clappy.command({
	name = "test",
	description = "test 2",

	parameters = {
		test = clappy.parameter({
			position = 1,
			description = "test",
			type = clappy.types.number(),
		}),
	},

	opts = {
		test2 = clappy.opt({
			description = "test",
			type = clappy.types.string(),
		}),
	},
}, function(parameters, opts)
	print(parameters.test)
	print(opts.test2)
end)

clappy
	.cli("randomIDL")
	:defineRootCommand(testCommand)
	:metadata({
		description = "yay",
		version = "1.0.0",

		author = "ffrostfall",

		afterHelp = "",
	})
	:defineSubcommand(clappy.command({
		name = "runthing",
		description = "Runs the thing",

		parameters = {
			first = clappy.parameter({
				position = 1,
				description = "first2",
				type = clappy.types.string(),
			}),
		},

		opts = {
			second = clappy.opt({
				description = "second2",
				type = clappy.types.string(),
			}),
		},
	}, function() end))
	:defineGlobalOpt("version", "yeah", function()
		print("yea")
	end)
	:run()
