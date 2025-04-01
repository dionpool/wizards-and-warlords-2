extends Button

func _on_pressed() -> void:
	var game_manager_scene = load("res://addons/game_manager/game_manager.tscn")
	get_tree().change_scene_to_packed(game_manager_scene)
