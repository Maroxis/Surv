extends Control

onready var scroll_container: ScrollContainer = $"%ScrollContainer"
onready var quick_bar: HBoxContainer = $"%QuickBar"
onready var seperation = quick_bar.get("custom_constants/separation")
onready var chest: TextureButton = $TextureButton
onready var items = quick_bar.get_children()
onready var itemsOrgPos = []
onready var inProgress = 0
onready var buffer = []

var hidden_items
onready var max_visible_items = 7

func _ready() -> void:
	hidden_items = max_visible_items
	Global.ResourcesUI = self
	scroll_container.rect_size.x = (items[0].rect_size.x + seperation)*max_visible_items
	scroll_container.scroll_horizontal = items[0].rect_size.x + seperation
	for item in items:
		itemsOrgPos.push_back(item.rect_position.x)

func update_resource():
	var buff = buffer.pop_front()
	buff["res"] = buff["res"].to_lower()
	var onDisplay = false
	for item in items:
		if(item.currentTex == buff["res"] && item.visible):
			onDisplay = item
	if(onDisplay):
		onDisplay.changeCount(buff["amm"])
		onDisplay.shake()
		chest.shake()
		if(not buffer.empty()):
				update_resource()
	else:
		var newItem = items[hidden_items]
		newItem.changeTexture(buff["res"])
		newItem.changeCount(buff["amm"])
		
		if(hidden_items > 0):
			showNext()
		else:
			swipeNext()
	return

func reset():
	for item in items:
		item.fadeOut(0.8)
		item.currentTex = null
	buffer.clear()
	hidden_items = max_visible_items

func showNext():
	items[hidden_items].fadeIn(0.8)
	hidden_items -= 1
	chest.shake()

func swipeNext():
	inProgress = items.size()
	var hurry = 0.5 if not buffer.empty() else 1.0
#	var hurry = 1.0
	for n in range(inProgress-1,-1,-1):
		var tween = create_tween().set_ease(Tween.EASE_OUT)
		tween.connect("finished", self, "pr")
		tween.tween_property(items[n], "rect_position:x", itemsOrgPos[n] + items[n].rect_size.x + seperation, 0.4*hurry)
		if(n == 0):
			tween.parallel().tween_property(items[n], "modulate:a", 1.0, 0.2*hurry)
		else:
			tween.tween_callback(items[n], "changeTexture", [items[n-1].currentTex])
			tween.tween_callback(items[n], "changeCount", [items[n-1].currentCount])
		tween.tween_property(items[n], "rect_position:x", itemsOrgPos[n], 0)
#		if(n == 1):
#			tween.tween_callback(items[n], "shake")
		if(n == 0):
			tween.tween_property(items[n], "modulate:a", 0.0, 0)
			tween.tween_callback(chest,"shake")

func _on_TextureButton_pressed() -> void:
	Global.ChestResources.toggle()

func addToBuffer(item,amm):
	buffer.push_back({"res":item,"amm":amm})

func pr():
	inProgress -= 1
	if(inProgress == 0 and not buffer.empty()):
		update_resource()

func addRes(res,amm,crafted):
	Global.ChestResources.update_resource(res,amm,crafted)
	addToBuffer(res,amm)
	if(inProgress == 0 && buffer.size() == 1):
		update_resource()
