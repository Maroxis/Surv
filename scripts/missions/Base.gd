extends MissionBasic

onready var drinkNode = get_node("VBoxContainer/HBox2/Drink")
onready var drinkNodeAmm = drinkNode.get_node("VBox/Ammount")
onready var drinkNodeLabel = drinkNode.get_node("VBox/Name")
onready var toxic_level = drinkNode.get_node("VBox/Button/ToxicLevel")
onready var defence_amm: Label = $"%DefenceAmm"

func _ready() -> void:
# warning-ignore:return_value_discarded
	Buildings.connect("moduleBuilt",self,"_checkMod")
# warning-ignore:return_value_discarded
	Events.connect("toxicRain",self,"changeCollectorToxic")

func updateGatherTime():
	return

func refresh():
	changeCollectorToxic()
	drinkNodeAmm.text = str(Buildings.getWaterLevel()) + "W"

func _on_Return_Button_pressed() -> void:
	close()

func _on_Sleep_Button_pressed() -> void:
	Player.sleep()
#	close()

func _on_Build_Button_pressed() -> void:
	Global.BaseAct.build.show()
	Global.BaseAct.build.refresh()
	Global.Sound.play(Sound.UI_DEFAULT, "SFX")
#	close(false)

func _on_Craft_Button_pressed() -> void:
	Global.BaseAct.craft.show()
	Global.BaseAct.craft.refresh()
	Global.Sound.play(Sound.UI_DEFAULT, "SFX")
#	close(false)

func _on_Status_Button_pressed() -> void:
	Global.BaseAct.status.show()
	Global.BaseAct.status.refresh()
	Global.Sound.play(Sound.UI_DEFAULT, "SFX")
#	close(false)

func _on_Drink_Button_pressed() -> void:
	var amm
	if(Player.water + Buildings.Structure["Collector"]["waterLevel"] > Player.maxWater):
		amm = Player.maxWater - Player.water
	else:
		amm = Buildings.Structure["Collector"]["waterLevel"]
	Player.change_water(amm)
	Buildings.changeWaterLevel(-amm)
	var sick = getSickAmm()
	if sick > 0:
		Player.change_sick(sick*amm)
	Global.Sound.play(Sound.UI_DRINKING, "SFX")

func getSickAmm():
	return Global.Weather.rainToxic - Buildings.getCurrentModule("Collector","Filter")["benefits"]["filter"]

func _checkMod(module):
	if module == "Filter":
		changeCollectorToxic()
	else:
		defence_amm.text = str(Buildings.calcDefence())

func changeCollectorToxic():
	var sick = clamp(getSickAmm(),0.0,1.0)
	toxic_level.value = sick

func _activateDrink():
	drinkNode.modulate = Color(1,1,1,1)
	drinkNodeLabel.text = tr("Drink")
	drinkNodeAmm.show()
	drinkNode.get_node("VBox/Button/Button").disabled = false
	
func _deactivateDrink():
	drinkNode.modulate = Color(1,1,1,0.4)
	drinkNodeLabel.text = tr("Build Collector")
	drinkNodeAmm.hide()
	drinkNode.get_node("VBox/Button/Button").disabled = true


func _on_Cook_Button_pressed() -> void:
	Global.BaseAct.cook.show()
	Global.BaseAct.cook.refresh()
	Global.Sound.play(Sound.UI_DEFAULT, "SFX")
#	close(false)


func _on_Home_visibility_changed() -> void:
	if visible:
		defence_amm.text = str(Buildings.calcDefence())
		if(Buildings.getTierInt("Collector","Tank") > 0):
			_activateDrink()
		else:
			_deactivateDrink()


func _on_Defence_pressed() -> void:
	Global.Intel.refresh()
	Global.Intel.show()
	Global.Sound.play(Sound.UI_DEFAULT, "SFX")
