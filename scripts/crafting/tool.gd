extends Craftable

onready var tName = get_node("HBoxContainer/VBoxContainer2/Name")
onready var tier = $HBoxContainer/VBoxContainer2/Tier
onready var cost = get_node("HBoxContainer/VBoxContainer/Cost")
onready var benefits = get_node("Benefits")
#onready var btOrgPos = craft_button.rect_position
onready var timeLb = $"%Time"

func _ready() -> void:
	var item = $HBoxContainer/VBoxContainer2/TextureRect
	craft_button = get_node("HBoxContainer2/CraftButton")
	loadTex(item)

func refresh():
	self.tName.text = self.name
	var ctier = Tools.getTier(self.name)
	if(Tools.tools[self.name].has("tier"+str(ctier+1))):
		_updateCost(ctier)
		_updateBene(ctier,false)
		_updateTime()
		self.tier.get_node("Next").text = str(ctier+1)
		self.tier.get_node("Current").text = str(ctier)
	else:
		craft_button.disabled = true
		fade()
#		_updateBene(ctier,true)
#		self.tier.get_node("Next").visible = false
#		self.tier.get_node("Spacer").visible = false
#		self.timeLb.text = ""
#		self.craft_button.disabled = true
#		self.craft_button.self_modulate = Color( 1, 1, 1, 0.2 )

func _updateCost(ctier):
	clearList(cost)
	populateList(cost,Tools.tools[self.name]["tier"+str(ctier+1)],"cost",true)
	toggleBT(cost_meet)

func _updateBene(ctier,lastTier):
	self.benefits.clear()
	if(!lastTier):
		for bene in Tools.tools[self.name]["tier"+str(ctier+1)]["benefits"]:
			var bamm = Tools.tools[self.name]["tier"+str(ctier+1)]["benefits"][bene]
			var cbamm = Tools.tools[self.name]["tier"+str(ctier)]["benefits"][bene]
			self.benefits.add_item(tr("Action speed"),null,false)
#			self.benefits.add_item(str(bene),null,false)
			self.benefits.add_item(str(cbamm)+" -> "+str(bamm),null,false)
			self.benefits.set_item_custom_fg_color(self.benefits.get_item_count()-1,Color(0, 1, 0, 1))
	else:
		for bene in Tools.tools[self.name]["tier"+str(ctier)]["benefits"]:
				var cbamm = Tools.tools[self.name]["tier"+str(ctier)]["benefits"][bene]
				self.benefits.add_item(tr("Action speed"),null,false)
				self.benefits.add_item(str(cbamm),null,false)
				self.benefits.set_item_custom_fg_color(self.benefits.get_item_count()-1,Color(0, 1, 0, 1))
				
func _on_CraftButton_pressed() -> void:
	if(Tools.checkCost(self.name)):
		Global.Sound.play(Sound.UI_TOOLS, "SFX")
		Tools.craftTool(self.name)
		craftBtAnim(true)
		Global.Craft.refreshCurTab()

func _updateTime():
	var ctier = Tools.getTier(self.name)
	timeLb.text = Global.timeGetFullFormat(Tools.tools[self.name]["tier"+str(ctier+1)]["craftTime"],true)
