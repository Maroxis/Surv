extends Control

func _ready() -> void:
	Global.WinScreen = self

func checkDay(day):
	if day == 100:
		show()

func _on_Continue_Button_pressed() -> void:
	hide()
