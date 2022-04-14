extends Node

var thirstRate = 0.08 #per minute
var hungerRate = 0.02 #per minute
var regenRate = 0.01 #per minute
var exhaustRate = 0.1 #per minute

var water = 40.0
var food = 80.0
var health = 100.0
var energy = 100.0

func refresh_status():
	Global.UI.get_node("Status/Water/TextureProgress").value = ceil(water)
	Global.UI.get_node("Status/Water/TextureProgress/Value").text= str(ceil(water))
	Global.UI.get_node("Status/Food/TextureProgress").value = ceil(food)
	Global.UI.get_node("Status/Food/TextureProgress/Value").text= str(ceil(food))
	Global.UI.get_node("Status/Health/TextureProgress").value = ceil(health)
	Global.UI.get_node("Status/Health/TextureProgress/Value").text= str(ceil(health))
	Global.UI.get_node("Status/Energy/TextureProgress").value = ceil(energy)
	Global.UI.get_node("Status/Energy/TextureProgress/Value").text= str(ceil(energy))

func change_water(amm, set = false):
	if(water == 0 && amm < 0):
		change_health(amm*2)
	if(set):
		water = amm
	else:
		water += amm
	water = clamp(water,0,100)
	Global.UI.get_node("Status/Water/TextureProgress").value = ceil(water)
	Global.UI.get_node("Status/Water/TextureProgress/Value").text= str(ceil(water))


func change_food(amm, set = false):
	if(food == 0 && amm < 0):
		change_health(amm*2)
	if(set):
		food = amm
	else:
		food += amm
	food = clamp(food,0,100)
	Global.UI.get_node("Status/Food/TextureProgress").value = ceil(food)
	Global.UI.get_node("Status/Food/TextureProgress/Value").text= str(ceil(food))
	
func change_health(amm, set = false):
	if(set):
		health = amm
	else:
		health += amm
	health = clamp(health,0,100)
	Global.UI.get_node("Status/Health/TextureProgress").value = ceil(health)
	Global.UI.get_node("Status/Health/TextureProgress/Value").text= str(ceil(health))

func change_energy(amm, set = false):
	if(energy == 0 && amm < 0):
		change_health(amm/2)
	if(set):
		energy = amm
	else:
		energy += amm
	energy = clamp(energy,0,100)
	Global.UI.get_node("Status/Energy/TextureProgress").value = ceil(energy)
	Global.UI.get_node("Status/Energy/TextureProgress/Value").text= str(ceil(energy))

func sleep():
	var sleepTime = 360
	var ctier = Buildings.Structure["House"]["currentTier"]
	var houseb = Buildings.Structure["House"]["tier"+str(ctier)]["benefits"]
	var sleepMult = houseb["sleepMult"]
	var sleepRegenMult= houseb["sleepRegenMult"]
	change_water(-(sleepTime*thirstRate*sleepMult))
	change_food(-(sleepTime*hungerRate*sleepMult))
	change_energy(100,true)
	if(food > 60 && water > 40):
		change_health(sleepTime*regenRate*sleepRegenMult)

func pass_time(time):
	change_water(-(time*thirstRate))
	change_food(-(time*hungerRate))
	change_energy(-(time*exhaustRate))
	if(food > 60 && water > 40):
		change_health(time*regenRate)
