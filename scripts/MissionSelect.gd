extends Control

onready var resName: Label = $VBox/Name
onready var ammount: Label = $VBox/Ammount
onready var time: Label = $VBox/Time
onready var button: Button = $VBox/Button/Button
onready var buttonContainer: Control = $VBox/Button
onready var toolReq: Label = $VBox/ToolReq
onready var icon: TextureRect = $VBox/Button/Icon

func updateGatherTime(tm):
	time.text = Global.timeGetFullFormat(tm)

func enable():
	toolReq.visible = false
	buttonContainer.modulate.a = 1.0
	button.disabled = false
	
func disable():
	toolReq.visible = true
	buttonContainer.modulate.a = 0.4
	button.disabled = true

func populate(rsNam,amm,tm,tlReq):
	resName.text = rsNam
	ammount.text = str(amm)+"x"
	time.text = Global.timeGetFullFormat(tm)
	icon.texture =  load("res://sprites/Icons/resources/"+rsNam.to_lower()+".png")
	if(tlReq):
		toolReq.text = tlReq["tool"] + str(tlReq["tier"]) + "\nRequired"
		disable()
