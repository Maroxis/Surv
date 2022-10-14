extends Control

class_name SceneLoader

func clearList(list):
	for n in list.get_children():
		n.queue_free()

func addScene(scene,container):
	var scene_instance = scene.instance()
	container.add_child(scene_instance)
	return scene_instance

func removeLastScene(container):
	var child = container.get_child(container.get_child_count()-1)
	child.free()

func addLabel(container):
	var new_label = Label.new()
	container.add_child(new_label)
	return new_label
