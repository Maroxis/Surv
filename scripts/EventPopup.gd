extends Control
onready var texture_button: TextureButton = $"%TextureButton"
onready var title: Label = $"%Title"
onready var desc: Label = $"%Desc"
onready var result: Label = $"%Result"


func _ready() -> void:
	Global.EventPopup = self

func show():
	self.rect_position.y = self.rect_size.y
	visible = true
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rect_position:y", 0.0, 0.5)
	tween.tween_property(texture_button, "disabled", false, 0.1)
	Global.Sound.play(Sound.UI_EVENTS, "SFX")
	

func hide():
	texture_button.disabled = true
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rect_position:y", self.rect_size.y, 0.7)
	tween.tween_property(self, "visible", false, 0.1)

func populate(tit,dsc,res):
	title.text = tit
	desc.text = dsc
	result.text = res

func _on_TextureButton_pressed() -> void:
	hide()
