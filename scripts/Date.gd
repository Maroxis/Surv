extends Control

onready var day : int = 1
onready var time : int = 720
onready var dayLabel = get_node("Calendar/VBoxContainer/Day")
onready var timeLabel = get_node("Calendar/VBoxContainer/Time")

signal newDay 
signal timeChanged 
#signal timePassed

func _ready() -> void:
	Global.Date = self
	refresh()
# warning-ignore:return_value_discarded
	connect("newDay", Events, "check_event")
# warning-ignore:return_value_discarded
	connect("timeChanged",Global.Weather,"setTime")

func getDay():
	return int(day)

func pack():
	var data = {}
	data["day"] = day
	data["time"] = time
	return data

func unpack(data):
	day = int(data["day"])
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

func updateLabels() -> void:
	dayLabel.text = "Day " + str(day)
	timeLabel.text = Global.timeGetFullFormat(time,true)
