extends IndicatorPopup

func _ready() -> void:
	container = $FoodContainer
	scene = load("res://nodes/components/FoodItem.tscn")
	Global.FoodEat = self

func populateItems():
	for res in Inventory.food:
		if(Inventory.food[res].has("calories") and Inventory.get_food_amm(res) > 0):
			var scene_instance = scene.instance()
			container.add_child(scene_instance)
			scene_instance.init(res)
			scene_instance.connect("itemClicked",self,"eatFood")

func eatFood(food,node):
	var left = Player.eat(food,1,true)
	if left == 0:
		node.shake()
	else:
		node.shakeSide()
	refresh()
