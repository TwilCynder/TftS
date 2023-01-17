extends Enemy

onready var sprite: AnimatedSprite = $Sprite

func _ready():
	enemy_type = "Bat"

func _process(delta):
	if not is_blocked():
		sprite.flip_h = current_speed.x < 0

func die():
	position.y -= 8
	.die()

func _on_Hitbox_hit(hitbox, hurtbox: Hurtbox):
	print(hurtbox.owner)

