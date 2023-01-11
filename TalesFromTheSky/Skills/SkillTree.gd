extends Node

class_name SkillTree

var skills: Dictionary = {}

func _create_list(node: Skill) -> void:
	skills[node.name] = node
	for child in node.get_children():
		_create_list(child)
	
func _ready():
	for child in get_children():
		_create_list(child)
	print(skills.size())

func get_skill(name: String) -> Skill:
	return skills[name]
