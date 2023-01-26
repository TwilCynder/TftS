extends Hitbox

class_name IceHitbox

var enemy_hit = false

func _ready():
	pass

func _on_animation_finished():
	pass

func _freeze_enemy(enemy: Enemy):
	enemy_hit = true
	enemy.ice_freeze(3)

func _on_Hitbox_hit(hitbox, hurtbox):
	if hurtbox.owner and hurtbox.owner is Enemy:
		_freeze_enemy(hurtbox.owner)
