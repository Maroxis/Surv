extends Control

onready var resources: HBoxContainer = $"%Resources"
onready var rawList = resources.get_node("Raw/List")
onready var craftedList = resources.get_node("Crafted/List")

func _ready() -> void:
	Global.ChestResources = self
	loadRes()

func loadRes():
	var scene = load("res://nodes/ItemCount.tscn")
	for res in Inventory.resources:
		var scene_instance = scene.instance()
		if(Inventory.resources[res]["crafted"]):
			craftedList.add_child(scene_instance)
		else:
			rawList.add_child(scene_instance)
		scene_instance.set_name(res)
		scene_instance.changeTexture(res.to_lower())
		

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
