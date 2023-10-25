extends BaseActivity

var building
onready var graph_edit: GraphEdit = $GraphEdit
onready var scene = load("res://nodes/components/BuildingTreeModuleNode.tscn")
onready var sceneTab = load("res://nodes/components/TabSwithcerTab.tscn")
onready var v_scroll_bar: VScrollBar = $VScrollBar
onready var bg: TextureRect = $BGCanvasRed
onready var canvas_layer: CanvasLayer = $CanvasLayer
onready var module_detailed: Control = $CanvasLayer/ModuleDetailed
onready var tab_container: VBoxContainer = $CanvasLayer/TabSwitcher/TabContainer
onready var xmargin = 192
var catOffsets = []

signal scrollChanged
signal showed
signal hidden

func _ready() -> void:
	graph_edit.get_zoom_hbox().visible = false
	var offset = 32 + 128
	for structure in Buildings.Structure:
		catOffsets.push_back(float(offset-128-6))
		offset = create_modules(structure,offset)
	v_scroll_bar.max_value = offset - 720 + 16
# warning-ignore:return_value_discarded
	module_detailed.connect("moduleConstructed",self,"refresh")
	create_tabs()
	refresh()

func refresh():
	for mod in graph_edit.get_children():
		if mod is GraphNode:
			if mod.level == null:
				continue
			var clv = Buildings.getTierInt(mod.buildingName,mod.moduleName)
			if mod.level <= clv:
				mod.set_bought()
			elif mod.level == clv+1 and Buildings.checkIfReqFullfiled(mod.buildingName,mod.moduleName,mod.level):
				mod.set_avaliable()
			else:
				mod.set_locked()

func create_tabs():
	var tab = 0
	for struct in Buildings.Structure:
		create_quick_tab(struct,tab)
		tab += 1
	
func create_quick_tab(nm,tb):
	var tab = addScene(sceneTab,tab_container)
	tab.changeIcon(nm,256)
	tab.tab = tb
	tab.connect("tabClicked",self,"scroll_to")
	
func scroll_to(tb):
	scroll(catOffsets[tb],true)
#	scroll(y,true)

func create_modules(structure,mainOffset):
	var nodes = {}
	var curOffset = mainOffset
	building = Buildings.Structure[structure]
	var modnum = 0
	for module in Buildings.Structure[structure]:
		var moduleDict = Buildings.Structure[structure][module]
		if typeof(moduleDict) != TYPE_DICTIONARY:
			continue
		nodes[module] = []
		var tier = 1
		var reqtier = 0
		if Buildings.Structure[structure][module]["tier1"].has("required") and Buildings.Structure[structure][module]["tier1"]["required"].has("module"):
				for reqmod in Buildings.Structure[structure][module]["tier1"]["required"]["module"]:
					if Buildings.Structure[structure][module]["tier1"]["required"]["module"][reqmod] > reqtier:
						reqtier = Buildings.Structure[structure][module]["tier1"]["required"]["module"][reqmod]
		while(Buildings.Structure[structure][module].has("tier"+str(tier))):
			var tr = tier
			tr += reqtier
			var mod = addScene(scene,graph_edit)
			nodes[module].push_back(mod)
			mod.offset.x = (tr)*(mod.rect_size.x + 32) + xmargin
			mod.offset.y = (modnum)*(mod.rect_size.y + 4) + mainOffset
			mod.connect("selectedNode",self,"_on_GraphEdit_node_selected")
# warning-ignore:return_value_discarded
			connect("scrollChanged",mod,"update_button_offset")
# warning-ignore:return_value_discarded
			connect("showed",mod,"show")
# warning-ignore:return_value_discarded
			connect("hidden",mod,"hide")
			mod.init(structure,module,tier,tr)
			if tr == 1:
				mod.set_avaliable()
			if not moduleDict.has("tier"+str(tier+1)) and not moduleDict["benefitsText"].has("enable"):
				mod.set_slot_enabled_right(0, false)
			if tier > 1:
# warning-ignore:return_value_discarded
				graph_edit.connect_node(nodes[module][tier-2].name,0,mod.name,0)
			if moduleDict["tier"+str(tier)].has("required") and  moduleDict["tier"+str(tier)]["required"].has("module"):
				var curReqTier = 0
				var reqNode = null
				for reqmod in moduleDict["tier"+str(tier)]["required"]["module"]:
					if moduleDict["tier"+str(tier)]["required"]["module"][reqmod] > curReqTier:
						curReqTier = moduleDict["tier"+str(tier)]["required"]["module"][reqmod]
						reqNode = reqmod
				if reqNode != null:
# warning-ignore:return_value_discarded
					graph_edit.connect_node(nodes[reqNode][curReqTier-1].name,0,mod.name,0)
			curOffset = mod.offset.y + (mod.rect_size.y + 4)*2
			tier += 1
		modnum += 1
	nodes["structure"] = addScene(scene,graph_edit)
	nodes["structure"].set_slot_enabled_left(0, false)
	nodes["structure"].offset.y = (mainOffset + curOffset) / 2 - nodes["structure"].rect_size.y - 4
	nodes["structure"].offset.x = xmargin
	nodes["structure"].init(structure)
	nodes["structure"].set_bought()
	for mod in nodes:
		if typeof(nodes[mod]) == TYPE_ARRAY and nodes[mod][0].column == 1:
# warning-ignore:return_value_discarded
			graph_edit.connect_node(nodes["structure"].name,0,nodes[mod][0].name,0)
	return curOffset

func show():
	emit_signal("showed")
	self.visible = true
	canvas_layer.show()

func close():
	emit_signal("hidden")
	self.hide()
	canvas_layer.hide()

func _on_GraphEdit_node_selected(node: Node) -> void:
	module_detailed.init(node.buildingName,node.moduleName,node.level)
	Global.Sound.play(Sound.UI_DEFAULT_SHORT, "SFX")

func _on_Return_Button_pressed() -> void:
	close()

func _on_VScrollBar_value_changed(value: float) -> void:
	graph_edit.scroll_offset.y = value
	emit_signal("scrollChanged",value)

func scroll(val,set = false):
	if set:
		var tween = create_tween().set_parallel()
		tween.tween_property(v_scroll_bar,"value",val,0.3)
		tween.tween_property(bg.get_material(), "shader_param/offset", Vector2(0.0,-val), 0.3)
	else:
		v_scroll_bar.value -= val
		bg.material.set_shader_param("offset", Vector2(0.0,-v_scroll_bar.value))

func _input(event):
	if self.visible and event is InputEventScreenDrag:
		var speed = 3.0
		scroll(event.relative.y*speed)
#		var tween = create_tween()
#		tween.tween_property(v_scroll_bar,"value",v_scroll_bar.value-event.relative.y*speed,0.1)
#		tween.tween_property(v_scroll_bar,"value",v_scroll_bar.value-event.relative.y*speed,0.1)
#		tween.tween_property(bg.get_material(), "shader_param/offset", Vector2(0.0,-(v_scroll_bar.value-event.relative.y)), 0.1)
		
		
