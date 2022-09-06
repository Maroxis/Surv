extends Control

onready var scene = load("res://nodes/BuildingModule.tscn")
onready var scene_bonus = load("res://nodes/ModuleBonus.tscn")
onready var scene_cost = load("res://nodes/ModuleCost.tscn")
onready var module_select = $HBoxContainer/ModuleSelect
onready var mod_container = $HBoxContainer/Container
onready var preview_icon: TextureRect = $"%Icon"
onready var bonus_list: VBoxContainer = $"%BonusList"
onready var costs_list: VBoxContainer = $"%CostsList"
onready var progress_time: Label = $"%ProgressTime"
onready var progress_time_texture: TextureProgress = $"%ProgressTimeTexture"
onready var module_name_label: Label = $"%ModuleName"
onready var build_button: Button = $"%BuildButton"
var resRequired
var ntier
var building
var selectedModule

func init(bd):
	building = bd
	resRequired = true
	ntier = null
	selectedModule = null
	refresh()
	show()
	
	
func refresh():
	disableButton()
	removeItems(mod_container)
	removeItems(bonus_list)
	removeItems(costs_list)
	addItems()
	writeInfo()

func addItems():
	for mod in Buildings.Structure[building]:
		if(typeof(Buildings.Structure[building][mod]) == TYPE_DICTIONARY):
			var tier = Buildings.getTier(building,mod,true)
			var disabled = false if tier else true
			if(tier and Buildings.Structure[building][mod][tier].has("required")):
				for req in Buildings.Structure[building][mod][tier]["required"]:
					var rtier = Buildings.Structure[building][mod][tier]["required"][req]
					var ctier = Buildings.Structure[building][req]["currentTier"]
					if(ctier < rtier):
						disabled = true
			_addItem(mod,disabled)

func removeItems(container):
	for n in container.get_children():
		n.queue_free()

func selectModule(module,node):
	for mod in mod_container.get_children():
		if(mod.selected):
			mod.deselect()
	node.select()
	selectedModule = module
	preview_icon.texture = load("res://sprites/Icons/128x128px/"+module.to_lower()+".png")
	writeInfo()
	
func writeInfo():
	disableButton()
	removeItems(bonus_list)
	removeItems(costs_list)
	if(not building or not selectedModule):
		return
	module_name_label.text = selectedModule
	ntier = Buildings.getTier(building,selectedModule,true)
	if(not ntier):
		return
	for bene in Buildings.Structure[building][selectedModule][ntier]["benefits"]:
		var scene_instance = scene_bonus.instance()
		bonus_list.add_child(scene_instance)
		scene_instance.desc.text = Buildings.Structure[building][selectedModule]["benefitsText"][bene]
		scene_instance.value.text = str(Buildings.Structure[building][selectedModule][ntier]["benefits"][bene])
	var costCheck = true
	for item in Buildings.Structure[building][selectedModule][ntier]["cost"]:
		var scene_instance = scene_cost.instance()
		costs_list.add_child(scene_instance)
		scene_instance.res_name.text = item
		scene_instance.tex.texture = load("res://sprites/Icons/32x32px/"+item.to_lower()+".png")
		var amm = Buildings.Structure[building][selectedModule][ntier]["cost"][item]
		scene_instance.value.text = str(amm)
		if(amm > Inventory.resources[item]["ammount"]):
			scene_instance.value.add_color_override("font_color", Color(1,1,0))
			costCheck = false
		else:
			scene_instance.value.add_color_override("font_color", Color(0,1,0))
	var totalSec = Buildings.Structure[building][selectedModule][ntier]["time"]["sections"]
	var compSec = Buildings.Structure[building][selectedModule][ntier]["time"]["completed"]
	progress_time_texture.max_value = totalSec
	progress_time_texture.value = compSec
	progress_time.text = str(compSec)+" / "+str(totalSec)
	if(compSec > 0):
		resRequired = false
	if (costCheck or not resRequired):
		enableButton()
	
func disableButton():
	build_button.disabled = true
	preview_icon.modulate = Color(1,0,0,0.4)
	
func enableButton():
	build_button.disabled = false
	preview_icon.modulate = Color(1,1,1,1)
	
func _addItem(name,disabled):
	var scene_instance = scene.instance()
	mod_container.add_child(scene_instance)
	scene_instance.init(name,disabled)
	scene_instance.connect("selected",self,"selectModule")

func _on_Return_Button_pressed() -> void:
	hide()

func _on_Build_Button_pressed() -> void:
	if(resRequired):
		Buildings.buyModule(building,selectedModule)
		resRequired = false
	var time = Buildings.Structure[building][selectedModule][ntier]["time"]["ammount"]
	Player.pass_time(time)
	Buildings.Structure[building][selectedModule][ntier]["time"]["completed"] += 1
	var totalSec = Buildings.Structure[building][selectedModule][ntier]["time"]["sections"]
	var compSec = Buildings.Structure[building][selectedModule][ntier]["time"]["completed"]
	progress_time_texture.max_value = totalSec
	progress_time_texture.value = compSec
	progress_time.text = str(compSec)+" / "+str(totalSec)
	if(totalSec == compSec):
		Buildings.buildModule(building,selectedModule)
		refresh()
