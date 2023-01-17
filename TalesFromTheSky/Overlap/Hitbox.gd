extends Area2D

class_name Hitbox

enum HitboxType {
	NONE,
	SWORD,
	SPELL,
	ENEMY_BASIC_ATTACK
}

export(HitboxType) var hitboxType = HitboxType.NONE

signal hit(hitbox, hurtbox)

onready var collisionShape: CollisionShape2D = $CollisionShape2D

func set_enabled(state: bool):
	collisionShape.disabled = state

func on_hit(hurtbox):
	emit_signal("hit", self, hurtbox)
