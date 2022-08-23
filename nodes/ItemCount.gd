extends NodeAnimated

onready var texture_rect: TextureRect = $TextureRect
onready var count: Label = $Count

var currentTex
var currentCount

func changeTexture(tex):
	texture_rect.texture = load("res://sprites/Icons/resources/"+tex+".png")
	currentTex = tex

func changeCount(amm):
	count.text = str(amm)
	currentCount = amm
