@tool

extends Control

signal save_attack(attack_data)
signal load_attack(attack_name)

# Details inputs
@onready var name_input = $AttackForm/DetailsForm/NameInput
@onready var description_input = $AttackForm/DetailsForm/DescriptionInput
@onready var type_input = $AttackForm/DetailsForm/TypeInput
@onready var tags_input = $AttackForm/DetailsForm/TagsInput

# Stats inputs
@onready var power_input = $AttackForm/StatsForm/PowerInput
@onready var speed_input = $AttackForm/StatsForm/SpeedInput
@onready var cooldown_input = $AttackForm/StatsForm/CooldownInput
@onready var range_input = $AttackForm/StatsForm/RangeInput
@onready var knockback_input = $AttackForm/StatsForm/KnockbackInput

# Button group
@onready var save_button = $ButtonGroup/Buttons/SaveButton
@onready var load_button = $ButtonGroup/Buttons/LoadButton

func _ready() -> void:
	save_button.pressed.connect(_on_save_button_pressed)
	load_button.pressed.connect(_on_load_button_pressed)

func _on_save_button_pressed() -> void:
	var attack_data = {
		"name": name_input.text,
		"description": description_input.text,
		"type": type_input.text,
		"tags": tags_input.text.split(","),
		"power": int(power_input.value),
		"speed": int(speed_input.value),
		"cooldown": float(cooldown_input.value),
		"range": float(range_input.value),
		"knockback": float(knockback_input.value)
	}
	
	if attack_data["name"].is_empty():
		push_error("Name input cannot be empty!")
		return
	
	var save_path = "res://resources/attacks/%s.json" % attack_data["name"]
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	file.store_string(JSON.stringify(attack_data))
	file.close()
	
	print("Attack saved: ", attack_data["name"])

func _on_load_button_pressed() -> void:
	var attack_name = name_input.text
	var load_path = "res://resources/attacks/%s.json" % attack_name
	
	if FileAccess.file_exists(load_path):
		var file = FileAccess.open(load_path, FileAccess.READ)
		var json_string = file.get_as_text()
		
		file.close()
		
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if parse_result == OK:
			var attack_data = json.get_data()
			
			name_input.text = attack_data["name"]
			description_input.text = attack_data["description"]
			type_input.text = attack_data["type"]
			tags_input.text = ",".join(attack_data["tags"])
			power_input.value = attack_data["power"]
			speed_input.value = attack_data["speed"]
			cooldown_input.value = attack_data["cooldown"]
			range_input.value = attack_data["range"]
			knockback_input.value = attack_data["knockback"]
		else:
			push_error("JSON Parse Error: " + json.get_error_message())
	else:
		push_error("File not found: " + load_path)
