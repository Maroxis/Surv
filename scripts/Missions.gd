extends Control

onready var woods: Control = $Woods
onready var river: Control = $River
onready var plains: Control = $Plains
onready var hills: Control = $Hills
onready var home: Control = $Home

signal missionClosed
signal missionOpened

func _ready() -> void:
	Global.Missions = self
	for mission in self.get_children():
		mission.connect("closed",self,"mission_closed")
		if mission is Mission:
			mission.connect("missionOpened",self,"mission_opened")
# warning-ignore:return_value_discarded
	connect("missionClosed",Events,"startEvent")
# warning-ignore:return_value_discarded
	connect("missionClosed",Save,"autoSave")

func refresh():
	for mission in self.get_children():
		if mission is Mission or mission is MissionBasic:
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

func mission_closed():
	emit_signal("missionClosed")
func mission_opened():
	emit_signal("missionOpened")
