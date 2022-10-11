extends BaseActivity

onready var enemy_value_label: Label = $"%EnemyValueLabel"
onready var base_value_label: Label = $"%BaseValueLabel"
onready var details_list: VBoxContainer = $"%DetailsList"
onready var destroyed_list: VBoxContainer = $"%DestroyedList"

onready var max_intel_lv = 3

func _ready() -> void:
	Global.Intel = self

func refresh():
	var estimatedAttack = Events.calcAttack()
	var intelLv = Buildings.getIntelLv()
	intelLv = min(intelLv,max_intel_lv)
	var unc = float(max_intel_lv+1 - intelLv) / 10
	enemy_value_label.text = str(max(round(estimatedAttack*(1-unc)),0)) + "-" + str(round(estimatedAttack*(1+unc)))
	base_value_label.text = str(Buildings.calcDefence())
	var modules = Buildings.getDefenceModules()
	clearList(details_list)
	for mod in modules:
		if mod["def"] > 0:
			var lb = addLabel(details_list)
			lb.text = str(mod["bname"]) + " " + Global.splitString(mod["mname"]) + ": " + str(mod["def"])
	clearList(destroyed_list)
	var destroyed = Buildings.getRecDestroyed()
	if destroyed != null:
		for mod in destroyed:
			var lb = addLabel(destroyed_list)
			lb.text = str(mod["bname"]) + " " + Global.splitString(mod["mname"])
	
