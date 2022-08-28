extends Control

onready var day = 1
onready var time = 720
onready var dayLabel = get_node("Calendar/VBoxContainer/Day")
onready var timeLabel = get_node("Calendar/VBoxContainer/Time")

signal newDay 
#signal timePassed

func _ready() -> void:
	updateLabels()
	Global.Date = self
	connect("newDay", Events, "check_event")

func changeTime(amm) -> void:
	time += int(amm)
	if(time > 1440):
		day += floor(time/1440)
		time = time % 1440
		emit_signal("newDay", day)
	updateLabels()

func updateLabels() -> void:
	dayLabel.text = "Day " + str(day)
	timeLabel.text = Global.timeGetFullFormat(time,true)
