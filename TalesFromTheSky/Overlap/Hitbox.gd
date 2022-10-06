extends Area2D

class_name Hitbox

enum HitboxType {
	NONE,
	SWORD,
	ENEMY_BASIC_ATTACK
}

var knockback = null

export(HitboxType) var hitboxType = HitboxType.NONE
