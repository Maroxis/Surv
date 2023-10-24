extends ToolButton

signal tabClicked
var tab

func _on_CategoryButton_pressed() -> void:
	emit_signal("tabClicked",tab)
	Global.Sound.play(Sound.UI_DEFAULT_SHORT, "SFX")
