extends Control

func _ready() -> void:
	Global.MissionButtons = self

func updateMissionTime(mission,time):
	get_node(mission).updateMissionTime(time)
