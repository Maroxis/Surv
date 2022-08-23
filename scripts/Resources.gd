extends Control

onready var resources: HBoxContainer = $"%Resources"

func _ready() -> void:
	Global.ChestResources = self

func update_resource(res,amm,crafted):
	var node
	if(crafted):
		node = resources.get_node("Crafted/List/"+res)
	else:
		node = resources.get_node("Raw/List/"+res)
	var count = node.get_node("Count")
	count.text = str(amm)

func toggle():
	visible = !visible
