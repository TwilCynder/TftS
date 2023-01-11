tool

extends Node

class_name Skill

export (String) var skill_name = "" setget _set_name
export (int) var xp_cost = 0

export (bool) var refresh_name = false setget _refresh_name

func _set_name(newName: String):
	skill_name = newName

func _refresh_name(b: bool):
	name = skill_name

func _ready():
	name = skill_name

func use(player: Player):
	pass
