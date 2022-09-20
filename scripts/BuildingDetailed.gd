extends Control

onready var scene = load("res://nodes/components/BuildingModule.tscn")
onready var scene_bonus = load("res://nodes/components/ModuleBonus.tscn")
onready var scene_cost = load("res://nodes/components/ModuleCost.tscn")
onready var module_select = $HBoxContainer/ModuleSelect
onready var mod_container = $HBoxContainer/Container
onready var preview_icon: TextureRect = $"%Icon"
onready var bonus_list: VBoxContainer = $"%BonusList"
onready var costs_list: VBoxContainer = $"%CostsList"
onready var progress_time: Label = $"%ProgressTime"
onready var progress_section: Label = $"%ProgressSection"
onready var progress_time_texture: TextureProgress = $"%ProgressTimeTexture"
onready var module_name_label: Label = $"%ModuleName"
onready var build_button: Button = $"%BuildButton"
onready var label_cost: Label = $"%LabelCost"

var resRequired
var ntier
var building
var selectedModule

func init(bd):
	building = bd
	ntier = null
	selectedModule = null
	refresh()
	clearInfo()
	show()
	
func refresh():
	disableButton()
	resRequired = true
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
			var tl = null
			var md = null
			if(tier and Buildings.Structure[building][mod][tier].has("required")):
				for reqCat in Buildings.Structure[building][mod][tier]["required"]:
					for req in Buildings.Structure[building][mod][tier]["required"][reqCat]:
						var rtier
						var ctier
						if(reqCat == "tool"):
							rtier = Buildings.Structure[building][mod][tier]["required"][reqCat][req]
							ctier = Tools.getTier(req)
							if(ctier < rtier):
								tl = req
						elif(reqCat == "module"):
							rtier = Buildings.Structure[building][mod][tier]["required"][reqCat][req]
							ctier = Buildings.Structure[building][req]["currentTier"]
							if(ctier < rtier):
								md = req
						if(ctier < rtier):
							disabled = true
			_addItem(mod,disabled,tl,md)

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
	resRequired = true
	if(not building or not selectedModule):
		return
	module_name_label.text = selectedModule
	var ctier = Buildings.getTier(building,selectedModule)
	ntier = Buildings.getTier(building,selectedModule,true)
	if(not ntier):
		return
	for bene in Buildings.Structure[building][selectedModule][ntier]["benefits"]:
		var beneVal = Buildings.Structure[building][selectedModule][ntier]["benefits"][bene]
		var curVal = Buildings.Structure[building][selectedModule][ctier]["benefits"][bene]
		if(beneVal == curVal):
			continue
		var scene_instance = scene_bonus.instance()
		bonus_list.add_child(scene_instance)
		scene_instance.desc.text = Buildings.Structure[building][selectedModule]["benefitsText"][bene]
		if(typeof(beneVal) == TYPE_BOOL or typeof(beneVal) == TYPE_STRING or typeof(beneVal) == TYPE_ARRAY):
			scene_instance.value.text = str(curVal)+" -> "+str(beneVal)
		else:
			scene_instance.value.text = str(curVal)+" -> "+ str(beneVal)
	var costCheck = true
	var totalSec = Buildings.Structure[building][selectedModule][ntier]["time"]["sections"]
	var compSec = Buildings.Structure[building][selectedModule][ntier]["time"]["completed"]
	if(Buildings.Structure[building][selectedModule][ntier].has("cost") and compSec == 0):
		label_cost.show()
		costs_list.show()
		for item in Buildings.Structure[building][selectedModule][ntier]["cost"]:
			var scene_instance = scene_cost.instance()
			costs_list.add_child(scene_instance)
			scene_instance.res_name.text = item
			scene_instance.tex.texture = load("res://sprites/Icons/32x32px/"+item.to_lower()+".png")
			var amm = Buildings.Structure[building][selectedModule][ntier]["cost"][item]
			scene_instance.value.text = str(amm)
			if(amm > Inventory.get_res_amm(item)):
				scene_instance.value.add_color_override("font_color", Color(1,1,0))
				costCheck = false
			else:
				scene_instance.value.add_color_override("font_color", Color(0,1,0))
	else:
		label_cost.hide()
		costs_list.hide()
		resRequired = false
	updateProgress(totalSec,compSec)
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
	
func _addItem(name,disabled,tl,md):
	var scene_instance = scene.instance()
	mod_container.add_child(scene_instance)
	scene_instance.init(name,disabled,tl,md)
	scene_instance.connect("selected",self,"selectModule")

func _on_Return_Button_pressed() -> void:
	clearInfo()
	hide()

func _on_Build_Button_pressed() -> void:
	if(resRequired):
		Buildings.buyModule(building,selectedModule)
		resRequired = false
	var time = Buildings.Structure[building][selectedModule][ntier]["time"]["ammount"]
	var bonus = getToolBonus()
	Player.pass_time(time/bonus)
	Buildings.Structure[building][selectedModule][ntier]["time"]["completed"] += 1
	var totalSec = Buildings.Structure[building][selectedModule][ntier]["time"]["sections"]
	var compSec = Buildings.Structure[building][selectedModule][ntier]["time"]["completed"]
	if(compSec == 1):
		label_cost.hide()
		costs_list.hide()
	updateProgress(totalSec,compSec)
	if(totalSec == compSec):
		Buildings.buildModule(building,selectedModule)
		refresh()

func getToolBonus():
	var bonus = 1
	if(Buildings.Structure[building][selectedModule][ntier].has("required")):
		if(Buildings.Structure[building][selectedModule][ntier]["required"].has("tool")):
			for tl in Buildings.Structure[building][selectedModule][ntier]["required"]["tool"]:
				var rTier = Buildings.Structure[building][selectedModule][ntier]["required"]["tool"][tl]
				var tlBon = Tools.getBonus(tl,rTier)
				bonus += (tlBon-1)
	return bonus

func clearInfo():
	preview_icon.texture = null
	progress_time_texture.value = 0
	progress_section.text = "Select Module"
	progress_time.text = ""

func updateProgress(totalSec,compSec):
	progress_time_texture.max_value = totalSec
	progress_time_texture.value = compSec
	progress_section.text = str(compSec)+" / "+str(totalSec)
	var time = Buildings.Structure[building][selectedModule][ntier]["time"]["ammount"]
	progress_time.text = Global.timeGetFullFormat(time/getToolBonus())
