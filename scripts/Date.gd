extends Control

onready var day = 1
onready var time = 720
onready var dayLabel = get_node("TextureRect/VBoxContainer/Day")
onready var timeLabel = get_node("TextureRect/VBoxContainer/Time")

func _ready() -> void:
	updateLabels()
	Global.Date = self

func changeTime(amm) -> void:
	time += amm
	if(time > 1440):
		day += floor(time/1440)
		time = time % 1440
	updateLabels()

func updateLabels() -> void:
	dayLabel.text = "Day " + str(day)
	timeLabel.text = str(floor(time/60)) + ":"
	timeLabel.text += "00" if(time % 60 == 0) else str(time % 60)
