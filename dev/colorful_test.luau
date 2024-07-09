local colorful = require("../colorful")

local blueBrightUnderline = colorful.combineStyles({ colorful.color.blueBright, colorful.modifier.underline })

print(blueBrightUnderline("Hello, world!"))
