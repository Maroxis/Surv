extends IndicatorItem

onready var buffs: VBoxContainer = $VBoxContainer/Buffs

func addBuffs(list):
	if list.has("sickGain"):
		addLabel("Sick gain rate",list["sickGain"])
	if list.has("sickReduction"):
		addLabel("Sick reduction rate",list["sickReduction"])
	if list.has("healthRegen"):
		addLabel("Health regen rate",list["healthRegen"])
	if list.has("time"):
		addLabel("Buff time",Global.timeGetFullFormat(list["time"],false,true))

func addLabel(desc,val):
	var new_label = Label.new()
	buffs.add_child(new_label)
	new_label.text = str(desc) + ": " + str(val)
