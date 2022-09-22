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
			mission.updateTravelTime()
			mission.updateGatherTime()

func pack():
	var data = {}
	for mission in self.get_children():
		if mission is Mission:
			data[mission.name] = {}
			data[mission.name]["missionTravelTime"] = mission.missionTravelTime
			data[mission.name]["gatherTime"] = mission.gatherTime
	return data

func unpack(data):
	for mission in self.get_children():
		if mission is Mission:
			mission.missionTravelTime = data[mission.name]["missionTravelTime"]
			mission.gatherTime = data[mission.name]["gatherTime"]
	return data
