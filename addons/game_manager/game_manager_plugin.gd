@tool

extends EditorPlugin

# Character
var game_character_editor
var game_character_dock

# Attack
var game_attack_editor
var game_attack_dock

func _enter_tree() -> void:
	game_character_editor = preload("res://addons/game_manager/character/game_character_editor.tscn")
	game_character_dock = game_character_editor
	
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL, game_character_dock)
	
	game_attack_editor = preload("res://addons/game_manager/attack/game_attack_editor.tscn")
	game_attack_dock = game_attack_editor
	
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL, game_attack_dock)
	
func _exit_tree() -> void:
	if game_character_dock:
		remove_control_from_docks(game_character_dock)
		game_character_dock.free()
	
	if game_attack_dock:
		remove_control_from_docks(game_attack_dock)
		game_attack_dock.free()
