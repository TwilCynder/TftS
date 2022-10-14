extends Node2D

class_name AI

var enemy

func init(enemy_):
	enemy = enemy_

func _ready():
	var parent = get_parent()
	#assert(parent is Enemy)
	enemy = parent# as Enemy
	pass # Replace with function body.
	
func process(delta):
	pass
	
func physics_process(delta):
	print("bordel")
	pass

func get_enemy():
	return enemy
