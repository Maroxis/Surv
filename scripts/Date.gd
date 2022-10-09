extends Control

onready var day : int = 1
onready var time : int = 420
onready var dayLabel = get_node("Calendar/VBoxContainer/Day")
onready var timeLabel = get_node("Calendar/VBoxContainer/Time")

signal newDay 
signal timeChanged 
signal timePassed

func _ready() -> void:
	Global.Date = self
	refresh()
# warning-ignore:return_value_discarded
	connect("newDay", Events, "check_event")
# warning-ignore:return_value_discarded
	connect("timeChanged",Global.Weather,"setTime")
# warning-ignore:return_value_discarded
	connect("newDay", Global.WinScreen,"checkDay")
#	connect("timeChanged",Global.Missions.woods,"toggleHerb")

func getDay():
	return int(day)
func getTime():
	return int(time)

func getTotalTime():
	return day * 1440 + time

func pack():
	var data = {}
	data["day"] = day
	data["time"] = time
	return data

func unpack(data):
	if data.has("day"):
		day = int(data["day"])
	if data.has("time"):
		time = int(data["time"])

func refresh():
	updateLabels()

func changeTime(amm) -> void:
	time += int(amm)
	if(time > 1440):
		day += int(float(time)/1440)
		time = time % 1440
		emit_signal("newDay", day)
	updateLabels()
	emit_signal("timeChanged",time)
	emit_signal("timePassed",amm)

func updateLabels() -> void:
	dayLabel.text = "Day " + str(day)
	timeLabel.text = Global.timeGetFullFormat(time,true)
