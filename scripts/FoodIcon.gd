extends NodeAnimated

onready var total: Label = $TextureProgress/total

func _ready() -> void:
	Global.FoodCounter = self
	refresh()

func refresh():
	total.text = str(Inventory.get_food_total_amm())

func _on_Food_Button_pressed() -> void:
	Global.FoodEat.open()
	Global.Sound.play(Sound.UI_DEFAULT_SHORT, "SFX")
	

