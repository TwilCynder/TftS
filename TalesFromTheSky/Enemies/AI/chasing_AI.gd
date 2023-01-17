extends AI

enum {
	WANDER,
	CHASE,
	STATES
}

export (int) var chase_speed: float = 70
export (int) var chase_acceleration: float = 70

var current_speed: float = 0

var hero: Player
var state = WANDER

onready var detector = $PlayerDetector

func _ready():
	print("Init chasing AI")
	hero = SceneManager.current_scene.get_hero()
	pass # Replace with function body.

func _wander(delta):
	pass #override me

func _chase(delta):
	if not enemy.is_blocked():
		current_speed = enemy.current_speed.length()
		current_speed += chase_acceleration * delta
		if current_speed >= chase_speed:
			current_speed = chase_speed
		enemy.current_speed = global_position.direction_to(hero.global_position) * current_speed

func physics_process(delta):
	match state:
		WANDER:
			_wander(delta)
		CHASE:
			_chase(delta)

func _on_PlayerDetector_player_entered(player):
	state = CHASE
