extends NodeAnimated

onready var icon: TextureRect = $Icon
onready var name_label: Label = $Name
onready var ammount_label: Label = $Ammount
onready var tool_button: ToolButton = $ToolButton
var item

signal itemClicked

func init(nm,button = false):
	self.name = nm
	tool_button.visible = button
	changeItem(nm)
	changeAmm(0)

func changeItem(nm):
	item = nm
	name_label.text = nm
	icon.texture = load("res://sprites/Icons/64x64px/"+nm.to_lower()+".png")
	
func changeAmm(amm):
	ammount_label.text = str(amm)


func _on_ToolButton_pressed() -> void:
	emit_signal("itemClicked",item)
