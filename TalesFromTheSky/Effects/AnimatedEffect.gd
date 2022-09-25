extends AnimatedSprite

class_name AnimatedEffect

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	play("Animate")

func _on_animation_finished():
	queue_free()
	
static func displayEffect(effect: AnimatedEffect, position: Vector2):
	effect.position = position;
	SceneManager.current_scene.add_child(effect)
