extends Area2D

class_name Hitbox

enum HitboxType {
	NONE,
	SWORD
}

var knockback = null

export(HitboxType) var hitboxType = HitboxType.NONE
