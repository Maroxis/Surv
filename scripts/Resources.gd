extends Control

func _ready() -> void:
	Global.ResourcesUI = self

func update_resource(res,amm):
	var node = get_node("GridContainer/"+res+"/Count")
	node.text = str(amm)
