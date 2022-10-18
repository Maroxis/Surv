extends SceneLoader

var building
onready var graph_edit: GraphEdit = $GraphEdit
onready var scene = load("res://nodes/components/BuildingTreeModuleNode.tscn")
onready var v_scroll_bar: VScrollBar = $VScrollBar
onready var bg: TextureRect = $BG

signal scrollChanged

func _ready() -> void:
	graph_edit.get_zoom_hbox().visible = false
	var offset = 16
	for structure in Buildings.Structure:
		offset = create_modules(structure,offset)
	v_scroll_bar.max_value = offset - 720 + 32

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
			mod.offset.x = (tr)*(mod.rect_size.x + 32)
			mod.offset.y = (modnum)*(mod.rect_size.y + 4) + mainOffset
			mod.connect("selectedNode",self,"_on_GraphEdit_node_selected")
			connect("scrollChanged",mod,"update_button_offset")
			mod.init(module,tier,tr)
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
	nodes["structure"].offset.y = (mainOffset + curOffset) / 2 - nodes["structure"].rect_size.y
	nodes["structure"].init(structure,null)
	nodes["structure"].set_bought()
	for mod in nodes:
		if typeof(nodes[mod]) == TYPE_ARRAY and nodes[mod][0].column == 1:
# warning-ignore:return_value_discarded
			graph_edit.connect_node(nodes["structure"].name,0,nodes[mod][0].name,0)
	return curOffset

func _on_GraphEdit_node_selected(node: Node) -> void:
	print(node.moduleName)

func _on_Return_Button_pressed() -> void:
	hide()


func _on_VScrollBar_value_changed(value: float) -> void:
	graph_edit.scroll_offset.y = value
	emit_signal("scrollChanged",value)

func _input(event):
	if event is InputEventScreenDrag:
		var speed = 2.0
		v_scroll_bar.value -= event.relative.y*speed
		bg.material.set_shader_param("offset", Vector2(0.0,-v_scroll_bar.value))
