extends Area2D

class_name Hurtbox

signal hit(hitbox, hurtbox)

export (bool) var enable_sparkle = false

var HitEffect = preload("res://Effects/Hit.tscn")

func _getHitEffect() -> AnimatedEffect:
	return HitEffect.instance()

static func computeHitPosition(hit: Area2D, hurt: Area2D) -> Vector2:
	return (hit.global_position + hurt.global_position) / 2

func _displayEffect(hitbox: Hitbox):
	AnimatedEffect.displayEffect(_getHitEffect(), computeHitPosition(hitbox, self) )

func _on_Hurtbox_area_entered(area):
	if (area is Hitbox):
		_displayEffect(area)
		emit_signal("hit", area as Hitbox, self)

