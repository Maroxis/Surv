extends Control

func _ready() -> void:
	Global.ResourcesUI = self

func update_resource(res,amm):
	var node = get_node("GridContainer/"+res)
	var count = node.get_node("Count")
	node.shake()
	count.text = str(amm)
