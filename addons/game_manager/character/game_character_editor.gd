@tool

extends Control

signal save_character(character_data)
signal load_character(character_name)

@onready var name_input = $CharacterForm/NameInput
@onready var description_input = $CharacterForm/DescriptionInput
@onready var power_input = $CharacterForm/PowerInput
@onready var tags_input = $CharacterForm/TagsInput
@onready var save_button = $CharacterForm/ButtonGroup/SaveButton
@onready var load_button = $CharacterForm/ButtonGroup/LoadButton

func _ready() -> void:
	save_button.pressed.connect(_on_save_button_pressed)
	load_button.pressed.connect(_on_load_button_pressed)

func _on_save_button_pressed() -> void:
	var character_data = {
		"name": name_input.text,
		"description": description_input.text,
		"power": int(power_input.value),
		"tags": tags_input.text.split(",")
	}
	
	if character_data["name"].is_empty():
		push_error("Name input cannot be empty!")
		return
	
	var save_path = "res://resources/characters/%s.json" % character_data["name"]
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	file.store_string(JSON.stringify(character_data))
	file.close()
	
	print("Character saved: ", character_data["name"])

func _on_load_button_pressed() -> void:
	var character_name = name_input.text
	var load_path = "res://resources/characters/%s.json" % character_name
	
	if FileAccess.file_exists(load_path):
		var file = FileAccess.open(load_path, FileAccess.READ)
		var json_string = file.get_as_text()
		
		file.close()
		
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if parse_result == OK:
			var character_data = json.get_data()
			
			name_input.text = character_data["name"]
			description_input.text = character_data["description"]
			power_input.value = character_data["power"]
			tags_input.text = ",".join(character_data["tags"])
		else:
			push_error("JSON Parse Error: " + json.get_error_message())
	else:
		push_error("File not found: " + load_path)
