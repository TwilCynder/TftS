extends Hitbox

func _ready():
	pass

func _on_animation_finished():
	pass

func _freeze_enemy(enemy: Enemy):
	enemy.ice_freeze(1)

func _on_Hitbox_hit(hitbox, hurtbox):
	if hurtbox.owner and hurtbox.owner is Enemy:
		_freeze_enemy(hurtbox.owner)
