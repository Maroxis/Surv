extends "res://scripts/BaseActivity.gd"

onready var building_detailed: Control = $BuildingDetailed
onready var scene = load("res://nodes/Building.tscn")
onready var building_container: HBoxContainer = $ScrollContainer/BuildingContainer

func _ready() -> void:
	populate()

func populate():
	_addMargin(192)
	for building in Buildings.Structure:
		_addItem(building)
	_addMargin(192)
	
	
func _addItem(name):
	var scene_instance = scene.instance()
	building_container.add_child(scene_instance)
	scene_instance.init(name)
	scene_instance.connect("buildingSelected",self,"_on_buildingSelected")	
func _addMargin(size):
	var node = Control.new()
	building_container.add_child(node)
	node.rect_min_size.x = size
	
func _on_buildingSelected(building) -> void:
	building_detailed.init(building)
	

