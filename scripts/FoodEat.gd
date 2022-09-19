extends Control

onready var food_container: HFlowContainer = $FoodContainer
onready var scene = load("res://nodes/components/FoodItem.tscn")

func _ready() -> void:
	Global.FoodEat = self

func open():
	refresh()
	show()

func close():
	hide()
	
func refresh():
	removeItems()
	populateItems()
	
func removeItems():
	for n in food_container.get_children():
		n.queue_free()

func populateItems():
	for res in Inventory.resources:
		if(Inventory.resources[res].has("calories") and Inventory.resources[res]["ammount"] > 0):
			var scene_instance = scene.instance()
			food_container.add_child(scene_instance)
			scene_instance.init(res)
			scene_instance.connect("foodClicked",self,"eatFood")

func eatFood(food,node):
	var left = Player.eat(food,1,true)
	if left == 0:
		node.shake()
	else:
		node.shakeSide()
	refresh()

func _on_Return_Button_pressed() -> void:
	close()
