extends Control

onready var tName = get_node("HBoxContainer/VBoxContainer2/Name")
onready var tier = get_node("HBoxContainer/VBoxContainer/Tier")
onready var cost = get_node("HBoxContainer/VBoxContainer/Cost")
onready var benefits = get_node("Benefits")
onready var button = get_node("HBoxContainer2/CraftButton")
var isTool = true

func refresh():
	self.tName.text = self.name
	self.cost.clear ( )
	self.benefits.clear ( )
	var ctier = Tools.tools[self.name]["currentTier"]
	if(Tools.tools[self.name].has("tier"+str(ctier+1))):
		self.cost.add_item("Cost")
		for mat in Tools.tools[self.name]["tier"+str(ctier+1)]["cost"]:
			var amm = Tools.tools[self.name]["tier"+str(ctier+1)]["cost"][mat]
			self.cost.add_item(str(mat)+" "+str(amm),null,false)
		for bene in Tools.tools[self.name]["tier"+str(ctier+1)]["benefits"]:
			var bamm = Tools.tools[self.name]["tier"+str(ctier+1)]["benefits"][bene]
			var cbamm = Tools.tools[self.name]["tier"+str(ctier)]["benefits"][bene]
			self.benefits.add_item(str(bene),null,false)
			self.benefits.add_item(str(cbamm)+" -> "+str(bamm),null,false)
			self.benefits.set_item_custom_fg_color(self.benefits.get_item_count()-1,Color(0, 1, 0, 1))
		self.tier.get_node("Next").text = str(ctier+1)
	else:
		for bene in Tools.tools[self.name]["tier"+str(ctier)]["benefits"]:
			var cbamm = Tools.tools[self.name]["tier"+str(ctier)]["benefits"][bene]
			self.benefits.add_item(str(bene),null,false)
			self.benefits.add_item(str(cbamm),null,false)
			self.benefits.set_item_custom_fg_color(self.benefits.get_item_count()-1,Color(0, 1, 0, 1))
		self.tier.get_node("Next").text = ""
		self.tier.get_node("Spacer").text = ""
		self.button.disabled = true
		self.button.self_modulate = Color( 1, 1, 1, 0.2 )
	self.tier.get_node("Current").text = str(ctier)


func _on_CraftButton_pressed() -> void:
	if(Tools.checkCost(self.name)):
		Tools.craftTool(self.name)
		refresh()
