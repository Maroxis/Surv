extends Control

onready var resources: HBoxContainer = $"%Resources"
onready var rawList = resources.get_node("Raw/ScrollContainer/List")
onready var craftedList = resources.get_node("Crafted/ScrollContainer/List")
onready var foodList = resources.get_node("Food/ScrollContainer/List")
onready var scene = load("res://nodes/components/ItemCount.tscn")

func _ready() -> void:
	Global.ChestResources = self
	createLists()
	loadRes()

func createLists():
	for res in Inventory.resources:
		var list = craftedList if Inventory.resources[res]["crafted"] else rawList
		_createList(list,res)
	for food in Inventory.food:
		_createList(foodList,food)

func _createList(list,res):
	var scene_instance = scene.instance()
	if !list.has_node(res):
		list.add_child(scene_instance)
		scene_instance.set_name(res)

func _loadSingleRes(list,res):
	var node = list.get_node(res)
	node.changeTexture(res,"64x64px")
	node.changeSize(64)
	if(list == foodList):
		node.changeCount(Inventory.get_food_amm(res))
	else:
		node.changeCount(Inventory.get_res_amm(res))
	
func loadRes():
	for res in Inventory.resources:
		var list = craftedList if Inventory.resources[res]["crafted"] else rawList
		_loadSingleRes(list,res)
	for food in Inventory.food:
		_loadSingleRes(foodList,food)

func clearList(list):
	for n in list.get_children():
		n.queue_free()

func refresh():
#	clearList(rawList)
#	clearList(craftedList)
#	clearList(foodList)
	createLists()
	loadRes()

func update_resource(res,amm,food):
	var node
	if(food):
		node = foodList.get_node(res)
	elif(Inventory.resources[res]["crafted"]):
		node = craftedList.get_node(res)
	else:
		node = rawList.get_node(res)
	var count = node.get_node("Count")
	count.text = str(amm)

func toggle():
	visible = !visible
