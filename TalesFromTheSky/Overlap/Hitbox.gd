extends Area2D

class_name Hitbox

enum HitboxType {
	NONE,
	SWORD
}

export(HitboxType) var hitboxType = HitboxType.NONE
