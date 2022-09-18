extends NodeAnimated

onready var icon: TextureRect = $Icon
onready var name_label: Label = $Name
onready var ammount_label: Label = $Ammount
onready var tool_button: ToolButton = $ToolButton
onready var bg: NinePatchRect = $BG
var item
signal itemClicked

func init(nm,button = false):
	self.name = nm
	tool_button.visible = button
	bg.self_modulate = Color(0,0.54,0.02) if button else Color(1,0.5,0)
	changeItem(nm)
	changeAmm(0)

func changeItem(nm):
	item = nm
	name_label.text = nm
	icon.texture = load("res://sprites/Icons/64x64px/"+nm.to_lower()+".png")
	
func changeAmm(amm):
	ammount_label.text = str(amm)

func ammColor(red):
	if(red):
		ammount_label.add_color_override("font_color", Color(1,0,0))
	else:
		ammount_label.add_color_override("font_color", Color(1,1,1))

func toggle(on):
	tool_button.disabled = !on
	bg.modulate = Color(1,1,1) if on else Color(0.4,0.4,0.4)

func _on_ToolButton_pressed() -> void:
	emit_signal("itemClicked",item)
