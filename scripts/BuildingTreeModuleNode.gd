extends GraphNode

var moduleName
var level
var column
var orgOffset = Vector2(0,0)
var initialized = false
onready var texture_rect: TextureRect = $TextureRect

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
	

func _on_Module_offset_changed() -> void:
	if initialized:
		if self.offset != orgOffset:
			self.offset = orgOffset
