extends Control

onready var resources: HBoxContainer = $"%Resources"
onready var rawList = resources.get_node("Raw/List")
onready var craftedList = resources.get_node("Crafted/List")
onready var foodList = resources.get_node("Food/List")

func _ready() -> void:
	Global.ChestResources = self
	createLists()
	loadRes()

func createLists():
	var scene = load("res://nodes/components/ItemCount.tscn")
	for res in Inventory.resources:
		var list
		var scene_instance = scene.instance()
		if(Inventory.resources[res].has("food")):
			list = foodList
		elif(Inventory.resources[res]["crafted"]):
			list = craftedList
		else:
			list = rawList
		if !list.has_node(res):
			list.add_child(scene_instance)
			scene_instance.set_name(res)

func loadRes():
	for res in Inventory.resources:
		var list
		if(Inventory.resources[res].has("food")):
			list = foodList
		elif(Inventory.resources[res]["crafted"]):
			list = craftedList
		else:
			list = rawList
		var node = list.get_node(res)
		node.changeTexture(res,"64x64px")
		node.changeSize(48)
		node.changeCount(Inventory.get_res_amm(res))

func clearList(list):
	for n in list.get_children():
		n.queue_free()

func refresh():
#	clearList(rawList)
#	clearList(craftedList)
#	clearList(foodList)
	createLists()
	loadRes()

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
