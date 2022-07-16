extends Node

class_name Stats

signal no_hp

export (int) var max_hp = 1
onready var hp = max_hp setget set_hp

func set_hp(hp_: int):
	hp = hp_
	if hp < 1:
		emit_signal("no_hp")
		
func decrease_hp():
	hp = hp - 1
