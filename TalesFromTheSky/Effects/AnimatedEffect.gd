extends AnimatedSprite

class_name AnimatedEffect

signal effect_end

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	play("Animate")

func _on_animation_finished():
	emit_signal("effect_end")
	queue_free()
	
static func displayEffect(effect: AnimatedEffect, position: Vector2):
	effect.position = position;
	SceneManager.current_scene.add_child(effect)
