extends Control

func _ready() -> void:
	Global.ToolsUI = self

func updateTool(tl,tier):
	var node = get_node("GridContainer/"+str(tl))
	match(tier):
		1:
			node.modulate = Color(0,0,0,1)
		2:
			node.modulate = Color(1,0.5,0,1)
		3:
			node.modulate = Color(1,1,1,1)
