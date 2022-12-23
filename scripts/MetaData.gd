extends Node

onready var data = {
	"Tutorial": {
		"startTutorials": false,
		"missionTutorials": false
	},
	"Progress": {}
}

func pack():
	return data

func unpack(dat):
	for key in dat:
		if typeof(dat[key]) == TYPE_DICTIONARY:
			for subkey in dat[key]:
				data[key][subkey] = dat[key][subkey]
		else:
			data[key] = dat[key]
