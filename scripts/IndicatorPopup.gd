extends Control

class_name IndicatorPopup

var container
var scene

func open():
	refresh()
	show()

func close():
	hide()
	
func refresh():
	removeItems()
	populateItems()
	
func removeItems():
	for n in container.get_children():
		n.queue_free()

func populateItems():
	return

func _on_Return_Button_pressed() -> void:
	close()
