extends Area2D

class_name Hitbox

enum HitboxType {
	NONE,
	SWORD,
	ENEMY_BASIC_ATTACK
}

export (int) var damage = 1

var knockback = null

export(HitboxType) var hitboxType = HitboxType.NONE

func computeEffectiveKnockback(posTarget: Vector2):
	if (knockback is Vector2):
		return knockback
	elif (knockback is int):
		return (position - posTarget) * (knockback / position.distance_to(posTarget))
	else:
		return Vector2.ZERO 
