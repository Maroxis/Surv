extends Popup
onready var texture_button: TextureButton = $"%TextureButton"
onready var title: Label = $"%Title"
onready var desc: Label = $"%Desc"
onready var result: Label = $"%Result"


func _ready() -> void:
	Global.EventPopup = self
	hide()

func show():
	visible = true
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.7)
	tween.tween_property(desc, "modulate", Color(1,1,1,1), 0.7)
	tween.tween_property(result, "modulate", Color(1,1,1,1), 0.7)
	tween.tween_property(texture_button, "disabled", false, 0.1)
	

func hide():
	texture_button.disabled = true
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(result, "modulate", Color(1,1,1,0), 0.3)
	tween.tween_property(desc, "modulate", Color(1,1,1,0), 0.3)
	tween.tween_property(self, "modulate", Color(1,1,1,0), 0.4)
	tween.tween_property(self, "visible", false, 0.1)

func populate(tit,dsc,res):
	title.text = tit
	desc.text = dsc
	result.text = res

func _on_TextureButton_pressed() -> void:
	hide()
