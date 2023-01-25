extends Hitbox

func _ready():
	pass

func connect_to_animation(anim: AnimatedSprite):
	anim.connect("animation_finished", self, "_on_animation_finished")
	
func _on_animation_finished():
	print("Destroy")

func _freeze_enemy(enemy: Enemy):
	enemy.freeze()

func _on_Hitbox_hit(hitbox, hurtbox):
	if hurtbox.owner and hurtbox.owner is Enemy:
		_freeze_enemy(hurtbox.owner)
