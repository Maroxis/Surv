extends Control

onready var time_label: Label = $TimeLabel

func changeTime(time):
	var days = str(int(time / 1440))
	var tm = Global.timeGetFullFormat(fmod(time,1440),true,true)
	time_label.text = days +"D " + tm
