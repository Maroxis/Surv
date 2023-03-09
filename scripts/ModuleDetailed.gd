extends Control

onready var scene_bonus = load("res://nodes/components/ModuleBonus.tscn")
onready var scene_cost = load("res://nodes/components/ModuleCost.tscn")
onready var module_select = $HBoxContainer/ModuleSelect
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

signal moduleConstructed

func init(bd,mod):
	building = bd
	ntier = null
	selectModule(mod)
	refresh()
	show()
	
func refresh():
	disableButton()
	resRequired = true
	removeItems(bonus_list)
	removeItems(costs_list)
	writeInfo()

func removeItems(container):
	for n in container.get_children():
		n.queue_free()

func selectModule(module):
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
	module_name_label.text = Global.tr_split(selectedModule)
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
		match(typeof(beneVal)):
			TYPE_BOOL:
				scene_instance.value.text = ""
			TYPE_STRING:
				scene_instance.value.text = str(beneVal)
			_:
				scene_instance.value.text = str(curVal)+" -> "+str(beneVal)
	var costCheck = true
	var totalSec = Buildings.Structure[building][selectedModule][ntier]["time"]["sections"]
	var compSec = Save.structures[building][selectedModule]["progress"]
	if(Buildings.Structure[building][selectedModule][ntier].has("cost") and compSec == 0):
		label_cost.show()
		costs_list.show()
		for item in Buildings.Structure[building][selectedModule][ntier]["cost"]:
			var scene_instance = scene_cost.instance()
			costs_list.add_child(scene_instance)
			scene_instance.res_name.text = Global.tr_split(item)
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

func close():
	hide()

func _on_Return_Button_pressed() -> void:
	close()

func _on_Build_Button_pressed() -> void:
	Global.Sound.play(Sound.UI_BLUEPRINTS, "SFX")
	preview_icon.shakeSubtle()
	if(resRequired):
		Buildings.buyModule(building,selectedModule)
		resRequired = false
	var time = Buildings.Structure[building][selectedModule][ntier]["time"]["ammount"]
	var bonus = getToolBonus()
	Player.pass_time(time/bonus)
	Save.structures[building][selectedModule]["progress"] += 1
	var totalSec = Buildings.Structure[building][selectedModule][ntier]["time"]["sections"]
	var compSec = Save.structures[building][selectedModule]["progress"]
	if(compSec == 1):
		label_cost.hide()
		costs_list.hide()
	updateProgress(totalSec,compSec)
	if(totalSec == compSec):
		Buildings.buildModule(building,selectedModule)
		emit_signal("moduleConstructed")
		close()

func getToolBonus():
	var bonus = 1
	if(Buildings.Structure[building][selectedModule][ntier].has("required")):
		if(Buildings.Structure[building][selectedModule][ntier]["required"].has("tool")):
			for tl in Buildings.Structure[building][selectedModule][ntier]["required"]["tool"]:
				var rTier = Buildings.Structure[building][selectedModule][ntier]["required"]["tool"][tl]
				var tlBon = Tools.getBonus(tl,rTier)
				bonus += (tlBon-1)
	return bonus
#
#func clearInfo():
#	preview_icon.texture = null
#	progress_time_texture.value = 0
#	progress_section.text = "Select Module"
#	progress_time.text = ""

func updateProgress(totalSec,compSec):
	progress_time_texture.max_value = totalSec
	progress_time_texture.value = compSec
	progress_section.text = str(compSec)+" / "+str(totalSec)
	var time = Buildings.Structure[building][selectedModule][ntier]["time"]["ammount"]
	progress_time.text = Global.timeGetFullFormat(time/getToolBonus())
