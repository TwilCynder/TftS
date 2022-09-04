extends Area2D

signal hit(hitbox)

func _on_Hurtbox_area_entered(area):
	if (area is Hitbox):
		emit_signal("hit", area as Hitbox)
