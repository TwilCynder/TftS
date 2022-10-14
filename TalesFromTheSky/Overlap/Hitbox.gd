extends Area2D

class_name Hitbox

enum HitboxType {
	NONE,
	SWORD,
	ENEMY_BASIC_ATTACK
}

export (int) var damage = 1
export(HitboxType) var hitboxType = HitboxType.NONE

var knockback = null

onready var collisionShape: CollisionShape2D = $CollisionShape2D

func set_enabled(state: bool):
	collisionShape.disabled = state

func computeEffectiveKnockback(posTarget: Vector2) -> Vector2:
	if (knockback is Vector2):
		return knockback
	elif (typeof(knockback) == TYPE_REAL):
		return (posTarget - global_position) * (knockback / global_position.distance_to(posTarget))
	else:
		return Vector2.ZERO 
