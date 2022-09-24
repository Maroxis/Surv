extends Control

func _ready() -> void:
	Global.ToolsUI = self

func updateTool(tl,tier,downgrade = false):
	var node = get_node("GridContainer/"+str(tl))
	match(tier):
		0:
			node.modulate = Color(0,0,0,0.2)
		1:
			node.modulate = Color(0,0,0,1)
		2:
			node.modulate = Color(1,0.3,0,1)
		3:
			node.modulate = Color(1,0.7,0,1)
		4:
			node.modulate = Color(1,1,1,1)
		_:
			print("default tool error") #dont remove
	if(downgrade):
		node.shake(5,0.05,true)
	else:
		node.shake(5)
