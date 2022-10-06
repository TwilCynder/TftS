extends Enemy

onready var sprite: AnimatedSprite = $Sprite

func _ready():
	enemy_type = "Bat"

func _process(delta):
	sprite.flip_h = current_speed.x < 0
