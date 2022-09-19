extends Control

onready var resources: HBoxContainer = $"%Resources"
onready var rawList = resources.get_node("Raw/List")
onready var craftedList = resources.get_node("Crafted/List")
onready var foodList = resources.get_node("Food/List")

func _ready() -> void:
	Global.ChestResources = self
	loadRes()

func loadRes():
	var scene = load("res://nodes/components/ItemCount.tscn")
	for res in Inventory.resources:
		var scene_instance = scene.instance()
		if(Inventory.resources[res].has("food")):
			foodList.add_child(scene_instance)
		elif(Inventory.resources[res]["crafted"]):
			craftedList.add_child(scene_instance)
		else:
			rawList.add_child(scene_instance)
		scene_instance.set_name(res)
		scene_instance.changeTexture(res,"64x64px")
		scene_instance.changeSize(48)
		scene_instance.changeCount(Inventory.get_res_amm(res))

func update_resource(res,amm,crafted):
	var node
	if(Inventory.resources[res].has("food")):
		node = foodList.get_node(res)
	elif(crafted):
		node = craftedList.get_node(res)
	else:
		node = rawList.get_node(res)
	var count = node.get_node("Count")
	count.text = str(amm)

func toggle():
	visible = !visible
