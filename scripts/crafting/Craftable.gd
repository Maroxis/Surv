extends Control

class_name Craftable

onready var list_item_scene = load("res://nodes/components/ListItem.tscn")
var craft_button
var cost_meet = false
var tool_meet = false

func refresh():
	return

func fade():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.connect("finished", self, "hide")
	tween.tween_property(self, "modulate", Color(0,0,0,0), 0.4)
	
func hide():
	self.visible = false
	
func craftBtAnim(_button,_btpos):
#	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	pass

func loadTex(item):
	var tex = self.name.to_lower()
	item.texture = load("res://sprites/Icons/128x128px/"+tex+".png")
	item.modulate = Color(0.0,0.0,0.0,1.0)
	
func addListItem(list,text,val,color = Color(0,0,0,1),icon = false):
	var scene_instance = list_item_scene.instance()
	list.add_child(scene_instance)
	scene_instance.desc.text = str(text)
	scene_instance.value.text = str(val)
	scene_instance.value.set("custom_colors/font_color", color)
	if(icon):
		scene_instance.icon.texture = load("res://sprites/Icons/32x32px/"+text.to_lower()+".png")

func clearList(list):
	for n in list.get_children():
		n.queue_free()
func populateList(list,dict,cat,wIcon = false):
	cost_meet = true
	for mat in dict[cat]:
		var amm = dict[cat][mat]
		if(amm > Inventory.get_res_amm(mat)):
			addListItem(list,mat,amm,Color(1,1,0,1),wIcon)
			cost_meet = false
		else:
			addListItem(list,mat,amm,Color(0,1,0,1),wIcon)

func toggleBT(on):
	if on:
		enableBT()
	else:
		disableBT()

func disableBT():
	craft_button.modulate.a = 0.4
	craft_button.disabled = true
func enableBT():
	craft_button.modulate.a = 1.0
	craft_button.disabled = false
