extends Control
onready var debug: VBoxContainer = $"%Debug"

func _ready() -> void:
	debug.visible = DevMode.on

func _on_Debug_Button_toggled(on) -> void:
	DevMode.DebugUI.switch(on)


func _on_Exit_Button_pressed() -> void:
	hide()
