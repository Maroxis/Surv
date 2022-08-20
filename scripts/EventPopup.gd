extends Popup
onready var texture_button: TextureButton = $NinePatchRect/HBoxContainer/VBoxContainer/TextureButton
onready var title: Label = $NinePatchRect/HBoxContainer/VBoxContainer/Title
onready var desc: Label = $NinePatchRect/HBoxContainer/VBoxContainer/Desc


func _ready() -> void:
	Global.EventPopup = self

func show():
	visible = true
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.7)
	tween.tween_property(texture_button, "disabled", false, 0.8)

func hide():
	texture_button.disabled = true
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate", Color(1,1,1,0), 0.7)
	visible = false

func populate(tit,dsc):
	title.text = tit
	desc.text = dsc

func _on_TextureButton_pressed() -> void:
	hide()
