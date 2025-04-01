extends Control

@onready var character_manager_button = $ButtonGroup/CharacterManagerButton
@onready var attack_manager_button = $ButtonGroup/AttackManagerButton
@onready var quit_button = $ButtonGroup/QuitButton

func _on_character_manager_pressed() -> void:
	var character_manager_scene = preload("res://addons/game_manager/character/game_character_editor.tscn")
	get_tree().change_scene_to_packed(character_manager_scene)

func _on_attack_manager_button_pressed() -> void:
	var attack_manager_scene = preload("res://addons/game_manager/attack/game_attack_editor.tscn")
	get_tree().change_scene_to_packed(attack_manager_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit(0)
