local sparser = require("sprotoparser")

local proto = {}

local types = [[

.package {
	type 0 : integer
	session 1 : integer
}

.player {
	id 0 : string
	level 1 : integer
}

]]
