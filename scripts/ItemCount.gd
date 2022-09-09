extends NodeAnimated

onready var texture_rect: TextureRect = $TextureRect
onready var count: Label = $Count

var currentTex
var currentCount

func changeTexture(tex,res = "32x32px"):
	var size = int(res.left(2))
	tex = tex.to_lower()
	texture_rect.texture = load("res://sprites/Icons/"+res+"/"+tex+".png")
	texture_rect.rect_min_size = Vector2(size,size)
	currentTex = tex

func changeCount(amm):
	count.text = str(amm)
	currentCount = amm

func changeSize(size):
	texture_rect.rect_min_size = Vector2(size,size)
