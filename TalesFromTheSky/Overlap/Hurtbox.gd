extends Area2D

class_name Hurtbox

signal hit(hitbox, hurtbox)

export (bool) var enable_sparkle = false
export (Array, Hitbox.HitboxType) var hit_by: Array = []

var owner_entity: MapEntity = null

var HitEffect = preload("res://Effects/Hit.tscn")

func _enter_tree():
	var parent: Node = get_parent()
	while not (parent is MapEntity) and parent != null:
		parent = parent.get_parent()
	if parent != null:
		owner_entity = parent

func _getHitEffect() -> AnimatedEffect:
	return HitEffect.instance()

static func computeHitPosition(hit: Area2D, hurt: Area2D) -> Vector2:
	return (hit.global_position + hurt.global_position) / 2

func _displayEffect(hitbox: Hitbox):
	AnimatedEffect.displayEffect(_getHitEffect(), computeHitPosition(hitbox, self) )

func collision(hitbox: Hitbox):
	_displayEffect(hitbox)
	emit_signal("hit", hitbox, self)
	hitbox.on_hit(self)

func checkHit(hitbox: Hitbox):
	if hit_by.empty() or (hitbox.hitboxType in hit_by):
		collision(hitbox)

func _on_Hurtbox_area_entered(area):
	if (area is Hitbox):
		checkHit(area as Hitbox)
