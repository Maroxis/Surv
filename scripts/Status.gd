extends "res://scripts/BaseActivity.gd"

onready var list = get_node("ScrollContainer/ItemList")
onready var scene_bonus = load("res://nodes/ModuleBonus.tscn")

func refresh():
	removeItems(list)
	for structure in Buildings.Structure:
		for module in Buildings.Structure[structure]:
			if(typeof(Buildings.Structure[structure][module]) != TYPE_DICTIONARY):
				continue
			print(Buildings.getCurrentModule(structure,module))
			var cmod = Buildings.getCurrentModule(structure,module)
			for bene in cmod["benefits"]:
				if bene == "defence":
					continue
				var cbamm = cmod["benefits"][bene]
				var scene_instance = scene_bonus.instance()
				list.add_child(scene_instance)
				scene_instance.desc.text = str(bene)
				scene_instance.value.text = str(cbamm)

func removeItems(container):
	for n in container.get_children():
		n.queue_free()
