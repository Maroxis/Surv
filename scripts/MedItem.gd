extends IndicatorItem

onready var sick_shielding_rate: Control = $VBoxContainer/Buffs/SickShieldingRate
onready var sick_reduction_rate: Control = $VBoxContainer/Buffs/SickReductionRate
onready var health_regen_rate: Control = $VBoxContainer/Buffs/HealthRegenRate
onready var time: TextureRect = $Time

func _ready() -> void:
	sick_shielding_rate.visible = false
	sick_reduction_rate.visible = false
	health_regen_rate.visible = false

func addBuffs(list):
	if list.has("sickGain"):
		sick_shielding_rate.visible = true
		setLabel(sick_shielding_rate,1/list["sickGain"])
	if list.has("sickReduction"):
		sick_reduction_rate.visible = true
		setLabel(sick_reduction_rate,list["sickReduction"])
	if list.has("healthRegen"):
		health_regen_rate.visible = true
		setLabel(health_regen_rate,list["healthRegen"])
	if list.has("time"):
		time.visible = true
		setLabel(time,Global.timeGetFullFormat(list["time"],false,true),false)

func setLabel(node,val, x = true):
	label = node.get_node("Label")
	label.text = str(val)
	if x:
		label.text += "x"
