extends Control

func _on_EN_pressed() -> void:
	TranslationServer.set_locale("en")

func _on_PL_pressed() -> void:
	TranslationServer.set_locale("pl")
