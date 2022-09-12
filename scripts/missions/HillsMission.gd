extends Mission

onready var exploreTable = [0,3,5,8,16]
onready var exploreTime = 20
onready var exploreCurrentProgress = 0
onready var exploreDiscovered = 1
onready var exploration_progress: TextureProgress = $"%ExplorationProgress"
onready var exploration_progress_label: Label = $"%LabelProgress"
onready var exploration_progress_label_time: Label = $"%LabelTime"
onready var explore: Control = $"%Explore"
onready var explore_button: TextureButton = $VBoxContainer/Explore/ExploreButton

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
		"Coal": 20
	}
	gatherAmm = {
		"Rock": 10,
		"CopperOre": 3,
		"TinOre": 6,
		"IronOre": 3,
		"Coal": 5
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

func explore():
	exploreCurrentProgress += 1
	if(exploreCurrentProgress == exploreTable[exploreDiscovered]):
		resources.get_children()[exploreDiscovered].show()
		exploreDiscovered += 1
		exploreCurrentProgress = 0
		if(exploreDiscovered == exploreTable.size()):
			explore.hide()
			return
	updateVisualEx()

func updateVisualEx():
	exploration_progress.max_value = exploreTable[exploreDiscovered]
	exploration_progress.value = exploreCurrentProgress
	exploration_progress_label.text = str(exploreCurrentProgress)+"/"+str(exploreTable[exploreDiscovered])
	exploration_progress_label_time.text = Global.timeGetFullFormat(exploreTime)

func _on_Explore_Button_pressed() -> void:
	if(Inventory.add_resource("Torch",-1)):
		explore()
	else:
		explore_button.shakeSide()
