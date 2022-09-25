extends AI

class_name ChasingAI

enum {
	WANDER,
	CAHSE,
	STATES
}

export (int) var chase_speed: int = 70

var hero: Player

func _ready():
	print("Init chasing AI")
	hero = SceneManager.current_scene.get_hero()
	pass # Replace with function body.

func physics_process(delta):
	enemy.current_speed = global_position.direction_to(hero.global_position) * chase_speed
