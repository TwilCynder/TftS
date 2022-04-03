extends Node2D

onready var sprite = $AnimatedSprite

func _ready():
	sprite.play("Animate")


func _on_AnimatedSprite_animation_finished():
	queue_free()
