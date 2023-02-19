extends Control
onready var texture_button: TextureButton = $"%TextureButton"
onready var title: Label = $"%Title"
onready var desc: Label = $"%Desc"
onready var result: Label = $"%Result"
onready var scroll_border: NinePatchRect = $"%ScrollBorder"
onready var mask_light: Light2D = $"%MaskLight"


func _ready() -> void:
	Global.EventPopup = self

func show():
	_deactivate_button()
	scroll_border.rect_position.y = self.rect_size.y + scroll_border.rect_size.y
	mask_light.position.y = self.rect_size.y * 1.5 + scroll_border.rect_size.y
	visible = true
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel()
	tween.connect("finished",self,"_activate_button")
	tween.tween_property(scroll_border, "rect_position:y", -48.0, 0.9)
	tween.tween_property(mask_light, "position:y", self.rect_size.y * 0.5, 0.9)
	Global.Sound.play(Sound.UI_EVENTS, "SFX")
	
func _activate_button():
	texture_button.disabled = false
func _deactivate_button():
	texture_button.disabled = true
func _set_invisible():
	self.visible = false

func hide():
	_deactivate_button()
	var tween = create_tween().set_ease(Tween.EASE_IN).set_parallel()
	tween.connect("finished",self,"_set_invisible")
	tween.tween_property(scroll_border, "rect_position:y", self.rect_size.y + scroll_border.rect_size.y, 0.4)
	tween.tween_property(mask_light, "position:y", self.rect_size.y * 1.5 + scroll_border.rect_size.y, 0.4)

func populate(tit,dsc,res):
	title.text = tit
	desc.text = dsc
	result.text = res

func _on_TextureButton_pressed() -> void:
	hide()
