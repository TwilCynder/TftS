extends Hitbox

class_name DamageHitbox

export (int) var damage = 1

var knockback = null

func computeEffectiveKnockback(posTarget: Vector2) -> Vector2:
	if (knockback is Vector2):
		return knockback
	elif (typeof(knockback) == TYPE_REAL):
		return (posTarget - global_position) * (knockback / global_position.distance_to(posTarget))
	else:
		return Vector2.ZERO 

func on_hit(hurtbox):
	emit_signal("hit", self, hurtbox)
