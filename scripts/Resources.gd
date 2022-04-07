extends Control

onready var vis = false
onready var tween = get_node("Tween")

func _on_Button_pressed() -> void:
	if(vis):
		hideMenu()
	else:
		showMenu()

func showMenu() -> void:
	vis = true
	tween.interpolate_property(self, "rect_position",self.rect_position, Vector2(self.rect_position.x-128,self.rect_position.y), 0.3,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
func hideMenu() -> void:
	vis = false
	tween.interpolate_property(self, "rect_position",self.rect_position, Vector2(self.rect_position.x+128,self.rect_position.y), 0.3,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func update_resource(res,amm):
	var node = get_node("List/Items/"+res+"/Count")
	node.text = str(amm)
