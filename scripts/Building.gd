extends Control

onready var tier = get_node("VBox/Hbox/VBox2/Tier")
onready var cost = get_node("VBox/Hbox/VBox2/Cost")
onready var benefits = get_node("VBox/Benefits")
onready var bName = get_node("VBox/Hbox/VBox/BG/VBox/Name")
onready var button = get_node("VBox/Hbox/VBox/BG/VBox/Button")
onready var buildingPanel = $VBox/Hbox/VBox

func refresh():
	self.bName.text = self.name
	self.cost.clear ( )
	self.benefits.clear ( )
	var ctier = Buildings.Structure[self.name]["currentTier"]
	if(Buildings.Structure[self.name].has("tier"+str(ctier+1))):
		self.cost.add_item("Cost")
		for mat in Buildings.Structure[self.name]["tier"+str(ctier+1)]["cost"]:
			var amm = Buildings.Structure[self.name]["tier"+str(ctier+1)]["cost"][mat]
			self.cost.add_item(str(mat)+" "+str(amm),null,false)
		for bene in Buildings.Structure[self.name]["tier"+str(ctier+1)]["benefits"]:
			var bamm = Buildings.Structure[self.name]["tier"+str(ctier+1)]["benefits"][bene]
			var cbamm = Buildings.Structure[self.name]["tier"+str(ctier)]["benefits"][bene]
			self.benefits.add_item(str(bene),null,false)
			self.benefits.add_item(str(cbamm)+" -> "+str(bamm),null,false)
			self.benefits.set_item_custom_fg_color(self.benefits.get_item_count()-1,Color(0, 1, 0, 1))
		self.tier.get_node("Next").text = str(ctier+1)
	else:
		for bene in Buildings.Structure[self.name]["tier"+str(ctier)]["benefits"]:
			var cbamm = Buildings.Structure[self.name]["tier"+str(ctier)]["benefits"][bene]
			self.benefits.add_item(str(bene),null,false)
			self.benefits.add_item(str(cbamm),null,false)
			self.benefits.set_item_custom_fg_color(self.benefits.get_item_count()-1,Color(0, 1, 0, 1))
		self.tier.get_node("Next").text = ""
		self.tier.get_node("Spacer").text = ""
		self.button.disabled = true
		self.button.self_modulate = Color( 1, 1, 1, 0.2 )
	self.tier.get_node("Current").text = str(ctier)
	
func _on_Construct_Button_pressed() -> void:
	if(Buildings.checkCost(self.name)):
		Buildings.build(self.name)
		refresh()
	else:
		buildingPanel.shake(5,0.05,true)
