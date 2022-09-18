extends Control

onready var scene = load("res://nodes/ItemSquareAmm.tscn")

signal itemClicked
var selected

func addItem(nm):
	var scene_instance = scene.instance()
	self.add_child(scene_instance)
	scene_instance.init(nm,true)
	scene_instance.connect("itemClicked",self,"itemClicked")

func itemClicked(item):
	selected = item
	emit_signal("itemClicked",item)
	
func shakeSelected():
	get_node(selected).shakeSide()
