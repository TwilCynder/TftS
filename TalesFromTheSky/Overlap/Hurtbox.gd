extends Area2D

class_name Hurtbox

signal hit(hitbox, hurtbox)

export (bool) var enable_sparkle = false

var HitEffect = preload("res://Effects/Hit.tscn")

func _on_Hurtbox_area_entered(area):
	if (area is Hitbox):
		var effect = HitEffect.instance()
		self.add_child(effect)
		emit_signal("hit", area as Hitbox, self)
