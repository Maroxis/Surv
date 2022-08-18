extends Node

var thirstRate = 0.09 #per minute
var hungerRate = 0.03 #per minute
var regenRate = 0.01 #per minute
var exhaustRate = 0.1 #per minute

var maxWater = 100
var maxFood = 100
var maxHealth = 100
var maxEnergy = 100

var lowWarning = 10

var water = 40.0
var food = 80.0
var health = 100.0
var energy = 100.0

func refresh_status():
	Global.UI.get_node("Status/Water/TextureProgress").animateValue(ceil(water))
	Global.UI.get_node("Status/Water/TextureProgress/Value").text= str(ceil(water))
	Global.UI.get_node("Status/Food/TextureProgress").animateValue(ceil(food))
	Global.UI.get_node("Status/Food/TextureProgress/Value").text= str(ceil(food))
	Global.UI.get_node("Status/Health/TextureProgress").animateValue(ceil(health))
	Global.UI.get_node("Status/Health/TextureProgress/Value").text= str(ceil(health))
	Global.UI.get_node("Status/Energy/TextureProgress").animateValue(ceil(energy))
	Global.UI.get_node("Status/Energy/TextureProgress/Value").text= str(ceil(energy))

func change_water(amm, set = false):
	if(water == 0 && amm < 0):
		change_health(amm*2)
	if(set):
		water = amm
	else:
		water += amm
	water = clamp(water,0,maxWater)
	_upd_water(amm)

func _upd_water(amm):
	Global.UI.get_node("Status/Water/TextureProgress").animateValue(ceil(water))
	if(water < lowWarning && amm < 0):
		Global.UI.get_node("Status/Water/TextureProgress").shake()
	Global.UI.get_node("Status/Water/TextureProgress/Value").text= str(ceil(water))
	
func upd_max_water(mx):
	maxWater += mx
	Global.UI.get_node("Status/Water/TextureProgress").max_value += mx
	
func change_food(amm, set = false):
	if(food == 0 && amm < 0):
		change_health(amm*2)
	if(set):
		food = amm
	else:
		food += amm
	food = clamp(food,0,maxFood)
	Global.UI.get_node("Status/Food/TextureProgress").animateValue(ceil(food))
	if(food < lowWarning && amm < 0):
		Global.UI.get_node("Status/Food/TextureProgress").shake()
	Global.UI.get_node("Status/Food/TextureProgress/Value").text= str(ceil(food))
	
func change_health(amm, set = false):
	if(set):
		health = amm
	else:
		health += amm
	health = clamp(health,0,maxHealth)
	Global.UI.get_node("Status/Health/TextureProgress").animateValue(ceil(health))
	if(health < lowWarning && amm < 0):
		Global.UI.get_node("Status/Health/TextureProgress").shake()
	Global.UI.get_node("Status/Health/TextureProgress/Value").text= str(ceil(health))

func change_energy(amm, set = false):
	if(energy == 0 && amm < 0):
		change_health(amm/2)
	if(set):
		energy = amm
	else:
		energy += amm
	energy = clamp(energy,0,maxEnergy)
	Global.UI.get_node("Status/Energy/TextureProgress").animateValue(ceil(energy))
	if(energy < lowWarning && amm < 0):
		Global.UI.get_node("Status/Energy/TextureProgress").shake()
	Global.UI.get_node("Status/Energy/TextureProgress/Value").text= str(ceil(energy))

func sleep():
	var sleepTime = 360
	pass_time(sleepTime,true)
func pass_time(time,sleep=false):
	var sleepMult = 1
	var sleepRegenMult = 1
	if(sleep):
		var ctier = Buildings.Structure["House"]["currentTier"]
		var houseb = Buildings.Structure["House"]["tier"+str(ctier)]["benefits"]
		sleepMult = houseb["sleepMult"]
		sleepRegenMult= houseb["sleepRegenMult"]
		change_energy(maxEnergy,true)
	else:
		change_energy(-(time*exhaustRate))
	if(food > 60 && water > 40):
		change_health(time*regenRate*sleepRegenMult)
	change_water(-(time*thirstRate*sleepMult))
	change_food(-(time*hungerRate*sleepMult))
	Buildings.runCollector(time)
	Global.Date.changeTime(time)
