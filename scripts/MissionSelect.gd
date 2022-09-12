extends Control

onready var resName: Label = $VBox/Name
onready var ammount: Label = $VBox/Ammount
onready var time: Label = $VBox/Time
onready var button: Button = $VBox/Button/Button
onready var buttonContainer: Control = $VBox/Button

onready var tool_req: TextureRect = $VBox/Button/ToolReq
onready var tool_req_tier: Label = $VBox/Button/ToolReq/Tier

onready var icon: TextureRect = $VBox/Button/Icon

export var connectMission = true
export var customMission = false
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
	resName.text = rsNam
	ammount.text = str(amm)
	if(typeof(amm) != TYPE_STRING):
		ammount.text +="x"
	time.text = Global.timeGetFullFormat(tm)
	icon.texture =  load("res://sprites/Icons/64x64px/"+rsNam.to_lower()+".png")
	if(tlReq):
		tool_req.texture = load("res://sprites/Icons/32x32px/"+tlReq["tool"].to_lower()+".png")
		tool_req_tier.text = str(tlReq["tier"])
		disable()


func _on_Button_pressed() -> void:
	emit_signal("missionSelected",self.name)
