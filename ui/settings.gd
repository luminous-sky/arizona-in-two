extends Control

func _ready() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	var game: PackedScene = load("uid://85alntk1uqvy")
	SceneSwitcher.switch_scene(game)
