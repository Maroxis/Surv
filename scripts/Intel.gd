extends BaseActivity

onready var enemy_value_label: Label = $"%EnemyValueLabel"
onready var base_value_label: Label = $"%BaseValueLabel"
onready var details_list: VBoxContainer = $"%DetailsList"
onready var destroyed_list: VBoxContainer = $"%DestroyedList"
onready var bg_canvas_red: TextureRect = $BGCanvasRed
onready var scroll_container: ScrollContainer = $ScrollContainer

onready var max_intel_lv = 4

func _ready() -> void:
	Global.Intel = self
	scroll_container.get_v_scrollbar().connect("value_changed",self,"moveBG")

func refresh():
	var estimatedAttack = Events.calcAttack(true)
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
			lb.text = tr(str(mod["bname"])) + " " + Global.tr_split(mod["mname"]) + ": " + str(mod["def"])
	clearList(destroyed_list)
	var destroyed = Buildings.getRecDestroyed()
	if destroyed != null:
		for mod in destroyed:
			var lb = addLabel(destroyed_list)
			lb.text = tr(str(mod["bname"])) + " " + Global.tr_split(mod["mname"])
	

func moveBG(val):
	bg_canvas_red.material.set_shader_param("offset", Vector2(0,-val))
