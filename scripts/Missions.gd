extends Control

func _ready() -> void:
	Global.Missions = self

onready var woods: Control = $Woods
onready var river: Control = $River
onready var plains: Control = $Plains
onready var hills: Control = $Hills
onready var home: Control = $Home

func refresh():
	for mission in self.get_children():
		if mission is Mission:
			mission.refresh()

func pack():
	var data = {}
	for mission in self.get_children():
		data[mission.name] = mission.pack()
	return data

func unpack(data):
	for mission in self.get_children():
		mission.unpack(data[mission.name])
	return
