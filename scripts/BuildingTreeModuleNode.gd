extends GraphNode

var buildingName
var moduleName
var level
var column
var orgOffset = Vector2(0,0)
var initialized = false
var yOffset = 0
onready var texture_rect: TextureRect = $TextureRect
onready var tool_button: Button = $CanvasLayer/ToolButton
onready var canvas_layer: CanvasLayer = $CanvasLayer

signal selectedNode

func init(bd,nm = null,lv = null,col = null):
	buildingName = bd
	if nm == null:
		nm = buildingName
	moduleName = nm
	level = lv
	column = col
	orgOffset = self.offset
	initialized = true
	self.title = Global.splitString(nm)
	if level != null:
		self.title += " " + str(lv)
		texture_rect.texture = load("res://sprites/Icons/64x64px/"+nm.to_lower()+".png")
	else:
		texture_rect.texture = load("res://sprites/Icons/256x256px/"+nm.to_lower()+".png")


func set_bought():
	self.overlay = GraphNode.OVERLAY_POSITION
	set_slot_color_left(0,Color8(0,138,5))
	set_slot_color_right(0,Color8(0,138,5))
	tool_button.visible = false
func set_avaliable():
	self.overlay = GraphNode.OVERLAY_BREAKPOINT
	set_slot_color_left(0,Color8(255,179,72))
	set_slot_color_right(0,Color8(255,179,72))
	tool_button.visible = true
func set_locked():
	self.overlay = GraphNode.OVERLAY_DISABLED
	set_slot_color_left(0,Color8(48,56,56))
	set_slot_color_right(0,Color8(48,56,56))
	tool_button.visible = false

func update_pos_x(x):
	self.offset.x = x
	tool_button.rect_position.x = x

func update_pos_y(y):
	self.offset.y = y
	tool_button.rect_position.y = y + yOffset

func update_button_offset(off):
	yOffset = -off
	update_pos_y(self.offset.y)

func _on_Module_offset_changed() -> void:
	tool_button.rect_position.x = self.offset.x
	tool_button.rect_position.y = self.offset.y + yOffset
#	if initialized:
#		if self.offset != orgOffset:
#			self.offset = orgOffset

func show():
	.show()
	canvas_layer.visible = true
func hide():
	.hide()
	canvas_layer.visible =  false

func _on_Button_pressed() -> void:
	emit_signal("selectedNode",self)
