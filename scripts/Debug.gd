extends Control

onready var soak_meter: ProgressBar = $SoakMeter
onready var status: Control = $"%Status"

func _ready() -> void:
	DevMode.DebugUI = self
	switch(DevMode.on)

func switch(on):
	visible = on
	status.visible = on

func _on_TestButton_pressed() -> void:
	if(Global.Weather.current < Global.Weather.type.size() -1):
		Global.Weather.setWeather(Global.Weather.current+1)
	else:
		Global.Weather.setWeather(0)


func _on_AddResButton_pressed() -> void:
	DevMode.add_resources()
