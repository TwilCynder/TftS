extends "res://Enemies/AI/chasing_AI.gd"

func _on_hit(hitbox, hurtbox):
	enemy.current_speed = Vector2.ZERO
