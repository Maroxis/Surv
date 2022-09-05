extends Control

onready var scene = load("res://nodes/BuildingModule.tscn")
onready var module_select = $HBoxContainer/ModuleSelect
onready var mod_container = $HBoxContainer/Container
var building
var selectedModule

func init(bd):
	building = bd
	removeItems()
	addItems()
	show()
	
func addItems():
	for mod in Buildings.Structure[building]:
		_addItem(mod)

func removeItems():
	for n in mod_container.get_children():
		n.queue_free()

func selectModule(module,node):
	for mod in mod_container.get_children():
		if(mod.selected):
			mod.deselect()
	node.select()
	selectedModule = module
	print("module selected: ",module)
	
func _addItem(name):
	var scene_instance = scene.instance()
	mod_container.add_child(scene_instance)
	scene_instance.init(name)
	scene_instance.connect("selected",self,"selectModule")


func _on_Return_Button_pressed() -> void:
	hide()
