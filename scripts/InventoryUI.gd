extends SceneLoader

onready var scroll_container: ScrollContainer = $"%ScrollContainer"
onready var quick_bar: HBoxContainer = $"%QuickBar"
onready var seperation = quick_bar.get("custom_constants/separation")
onready var chest: TextureButton = $"%ChestButton"
onready var bag: Control = $"%Bag"
onready var container: Control = $"%Container"
onready var margin: Control = $HBoxContainer/Margin
onready var margin_2: Control = $HBoxContainer/Margin2
onready var margin_3: Control = $HBoxContainer/Margin3
onready var book_button: TextureButton = $HBoxContainer/BookButton

onready var itemsOrgPos = []
onready var inProgress = 0
onready var buffer = []
onready var scene = load("res://nodes/components/ItemCount.tscn")
onready var scrollOrgPos = scroll_container.rect_position.x
var hidden_items
onready var max_visible_items = 0
onready var marg_left = 0
onready var timer: Timer = $Timer
#var resizeInProgress = false

func _ready() -> void:
	Global.ResourcesUI = self
	addItem(0)
	hidden_items = max_visible_items
# warning-ignore:return_value_discarded
	get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")

func update_resource():
	var items = quick_bar.get_children()
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
	var items = quick_bar.get_children()
	for item in items:
		item.fadeOut(0.8)
		item.currentTex = null
	buffer.clear()
	hidden_items = max_visible_items

func showNext():
	var items = quick_bar.get_children()
	items[hidden_items].fadeIn(0.8)
	hidden_items -= 1
	chest.shake()

func swipeNext():
	var items = quick_bar.get_children()
	inProgress = items.size()
	var hurry = 0.5 if not buffer.empty() else 1.0
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

func addToBuffer(item,amm):
	buffer.push_back({"res":item,"amm":amm})

func pr():
	inProgress -= 1
	if(inProgress == 0 and not buffer.empty()):
		update_resource()

func addRes(res,amm,food,meds = false):
	Global.ChestResources.update_resource(res,amm,food,meds)
	if food:
		Global.FoodLookup.refresh()
	addToBuffer(res,amm)
	if(inProgress == 0 && buffer.size() == 1):
		update_resource()

func addItem(i):
	var sc = addScene(scene,quick_bar)
	sc.modulate.a = 0
	sc.rect_position.x = (sc.rect_size.x + seperation) * i
	itemsOrgPos.push_back(sc.rect_position.x)

func removeAll():
	clearList(quick_bar)
	itemsOrgPos.clear()

func removeItem():
	removeLastScene(quick_bar)
	itemsOrgPos.pop_back()

func _on_ChestButton_pressed() -> void:
	Global.ChestResources.toggle()

func resizeQuickBar():
	var isize = quick_bar.get_children()[0].rect_size.x + seperation
	var content = chest.rect_size.x + bag.rect_size.x + book_button.rect_size.x + margin_2.rect_size.x + margin_3.rect_size.x
	var ratio = get_viewport().size.x/get_viewport().size.y
	var diff = (get_viewport().size.y-720.0)*ratio
	var new_size = stepify(get_viewport().size.x - diff - marg_left - content - isize/2, isize)
	var new_max = int((new_size)/isize)
	max_visible_items = new_max-1
	hidden_items = max_visible_items
	removeAll()
	for i in new_max:
		addItem(i)
	var tween = create_tween().set_parallel(true)
	tween.tween_property(container,"rect_min_size:x",new_size + ceil(bag.rect_size.x/2),0.1)
	tween.tween_property(scroll_container,"rect_min_size:x",new_size,0.1)
#	container.rect_min_size.x = new_size + ceil(bag.rect_size.x/2)
#	scroll_container.rect_size.x = new_size
	return

func _on_viewport_size_changed() -> void:
	timer.start()

func _on_Timer_timeout() -> void:
#	if resizeInProgress:
#		timer.start()
#	else:
	resizeQuickBar()


func _on_BookButton_pressed() -> void:
	Global.GuideBook.toggle()
