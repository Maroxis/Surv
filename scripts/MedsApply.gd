extends IndicatorPopup

func _ready() -> void:
	container = $MedsContainer
	scene = load("res://nodes/components/MedItem.tscn")
	Global.MedsApply = self

func populateItems():
	for res in Inventory.meds:
		if(Inventory.get_meds_amm(res) > 0):
			var scene_instance = scene.instance()
			container.add_child(scene_instance)
			scene_instance.init(res)
			scene_instance.addBuffs(Inventory.meds[res]["buffs"])
			scene_instance.connect("itemClicked",self,"applyMed")
	if Player.medsBuff["time"] > 0:
		disableAll()

func applyMed(med,_node):
	Player.apply_med(med)
	Global.Sound.play(Sound.UI_HEART, "SFX")
	refresh()
	
func disableAll():
	for item in container.get_children():
		item.disable()
