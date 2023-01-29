extends Control

onready var resName: Label = $VBox/Name
onready var ammount: Label = $"%Ammount"
onready var time: Label = $VBox/Time
onready var button: Button = $VBox/Button/Button
onready var buttonContainer: Control = $VBox/Button
onready var weight: Label = $"%Weight"
onready var weight_container: TextureRect = $VBox/HBoxContainer/WeightContainer

onready var tool_req: TextureRect = $VBox/Button/ToolReq
onready var tool_req_tier: Label = $VBox/Button/ToolReq/Tier

onready var icon: TextureRect = $VBox/Button/Icon

export var connectMission = true
export var foodRes = false
export(String, "resources", "food", "meds", "null") var type = "resources"
export var sound = 7
signal missionSelected

func updateGatherTime(tm):
	time.text = Global.timeGetFullFormat(tm)

func enable():
	tool_req.visible = false
	buttonContainer.modulate.a = 1.0
	button.disabled = false
	
func disable():
	tool_req.visible = true
	buttonContainer.modulate.a = 0.4
	button.disabled = true

func populate(rsNam,amm,tm,tlReq):
	resName.text = Global.splitString(rsNam)
	ammount.text = str(amm)
	if(typeof(amm) != TYPE_STRING):
		ammount.text +="x"
	time.text = Global.timeGetFullFormat(tm)
	if type != "null":
		weight.text = str(Inventory[type][rsNam]["weight"])
	else:
		weight_container.hide()
	icon.texture =  load("res://sprites/Icons/64x64px/"+rsNam.to_lower()+".png")
	if(tlReq):
		tool_req.texture = load("res://sprites/Icons/32x32px/"+tlReq["tool"].to_lower()+".png")
		tool_req_tier.text = str(tlReq["tier"])
		disable()

func shake(suc):
	if suc:
		buttonContainer.shakeSubtle()
	else:
		buttonContainer.shakeSubtleSide()

func _on_Button_pressed() -> void:
	emit_signal("missionSelected",self.name,foodRes,self)
#	sound.play()
