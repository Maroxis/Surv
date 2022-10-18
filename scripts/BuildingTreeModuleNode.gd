extends GraphNode

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

func init(nm,lv,col = null):
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
func set_avaliable():
	self.overlay = GraphNode.OVERLAY_BREAKPOINT
	tool_button.visible = true

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
