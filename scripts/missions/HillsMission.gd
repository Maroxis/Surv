extends Mission

onready var exploreTable = [0,3,6,9,16]
onready var exploreTime = 40
onready var exploreCurrentProgress = 0
onready var exploreDiscovered = 1
onready var caveInTotal = 0
onready var caveInProgress = 0
onready var exploration_progress: TextureProgress = $"%ExplorationProgress"
onready var exploration_progress_label: Label = $"%LabelProgress"
onready var exploration_progress_label_time: Label = $"%LabelTime"
onready var explore_control: Control = $"%Explore"
onready var explore_button: TextureButton = $VBoxContainer/Explore/ExploreButton
onready var cave_in: Control = $"%CaveIn"
onready var cave_in_tex_pr: ProgressBar = $CaveIn/Info/TextureProgress
onready var cave_in_mission_select: Control = $CaveIn/Info/MissionSelect

func _ready() -> void:
	inOpen = false
	missionTravelTime = 160
	updateVisualEx()
	updateTravelTime()
	gatherTime = {
		"Rock": 30,
		"CopperOre": 50,
		"TinOre": 30,
		"IronOre": 80,
		"Coal": 40
	}
	gatherAmm = {
		"Rock": 10,
		"CopperOre": 3,
		"TinOre": 6,
		"IronOre": 3,
		"Coal": 4
	}
	toolReq = {
		"Rock": null,
		"CopperOre": {
			"tool":"Pickaxe",
			"tier": 1
		},
		"TinOre": {
			"tool":"Pickaxe",
			"tier": 2
		},
		"IronOre": {
			"tool":"Pickaxe",
			"tier": 3
		},
		"Coal": {
			"tool":"Pickaxe",
			"tier": 1
		}
	}
	toolBonus = {
		"Rock": "Pickaxe",
		"CopperOre": "Pickaxe",
		"TinOre": "Pickaxe",
		"IronOre": "Pickaxe",
		"Coal": "Pickaxe"
	}
	gatherTimeWBonus = gatherTime.duplicate()
	resources = $"%Resources"
	populateInfo()
# warning-ignore:return_value_discarded
	Tools.connect("toolChanged",self,"checkPick")

func checkPick(tl,_dn,_tr):
	if tl == "Pickaxe":
		refreshCaveIn()

func explore():
	exploreCurrentProgress += 1
	if(exploreCurrentProgress == exploreTable[exploreDiscovered]):
		resources.get_children()[exploreDiscovered].show()
		exploreDiscovered += 1
		exploreCurrentProgress = 0
		exploreTime += 20
	updateVisualEx()
	Player.pass_time(exploreTime)

func refresh():
	updateTravelTime()
	updateGatherTime()
	revealAllEplored()
	updateVisualEx()
	refreshCaveIn()
	
func refreshCaveIn():
	cave_in.visible = caveInTotal != 0
	cave_in_tex_pr.value = caveInProgress
	cave_in_tex_pr.max_value = caveInTotal
	cave_in_mission_select.updateGatherTime(getCaveInTime())

func revealAllEplored():
	var res = resources.get_children()
	for i in exploreDiscovered:
		res[i].show()

func updateVisualEx():
	if exploreDiscovered == exploreTable.size():
		explore_control.hide()
		return
	exploration_progress.max_value = exploreTable[exploreDiscovered]
	exploration_progress.value = exploreCurrentProgress
	exploration_progress_label.text = str(exploreCurrentProgress)+"/"+str(exploreTable[exploreDiscovered])
	exploration_progress_label_time.text = Global.timeGetFullFormat(exploreTime)

func _on_Explore_Button_pressed() -> void:
	Global.Sound.play(Sound.UI_DEFAULT, "SFX")
	if(Inventory.add_resource("Torch",-1)):
		explore_button.shakeSubtle()
		explore()
	else:
		explore_button.shakeSubtleSide()

func pack():
	var data = {}
	data["missionTravelTime"] = missionTravelTime
	data["gatherTime"] = gatherTime
	data["exploreTime"] = exploreTime
	data["exploreCurrentProgress"] = exploreCurrentProgress
	data["exploreDiscovered"] = exploreDiscovered
	data["caveInTotal"] = caveInTotal
	data["caveInProgress"] = caveInProgress
	return data

func unpack(data):
	if data.has("missionTravelTime"):
		missionTravelTime = data["missionTravelTime"]
	if data.has("gatherTime"):
		gatherTime = data["gatherTime"]
	if data.has("exploreTime"):
		exploreTime = data["exploreTime"]
	if data.has("exploreCurrentProgress"):
		exploreCurrentProgress = data["exploreCurrentProgress"]
	if data.has("exploreDiscovered"):
		exploreDiscovered = data["exploreDiscovered"]
	if data.has("caveInTotal"):
		caveInTotal = data["caveInTotal"]
	if data.has("caveInProgress"):
		caveInProgress = data["caveInProgress"]
	return

func enableCaveIn(amm):
	cave_in_mission_select.updateGatherTime(getCaveInTime())
	caveInTotal = amm
	cave_in_tex_pr.max_value = amm
	cave_in.show()

func disableCaveIn():
	cave_in.hide()
	caveInProgress = 0
	caveInTotal = 0
	cave_in_tex_pr.max_value = 0

func digCaveIn():
	caveInProgress += 1
	cave_in_tex_pr.value = caveInProgress
	if caveInProgress >= caveInTotal:
		disableCaveIn()

func getCaveInTime():
	return 120 / Tools.getBonus("Pickaxe")

func _on_CaveInButton_pressed() -> void:
	Player.pass_time(getCaveInTime())
	digCaveIn()
