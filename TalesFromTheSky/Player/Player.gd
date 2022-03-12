extends KinematicBody2D

enum {
	FREE,
	ATTACK
}

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	print("Hello there !")
	animationTree.active = true

const WALK_SPEED = 100
var ACCELERATION = 200

var state = FREE
var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
#var direction = "Right"

func start_state_attack():
	state = ATTACK
	animationState.travel("Attack")

func start_state_free():
	state = FREE

func attack_animation_finished():
	start_state_free()

func _physics_process(delta):
	match state:
		FREE:	
			free_state(delta)
		ATTACK:
			attack_state(delta)
		
func attack_state(delta):
	pass
		
func setAnimDirection(input_vector):
	animationTree.set("parameters/Idle/blend_position", input_vector)
	animationTree.set("parameters/Run/blend_position", input_vector)
	animationTree.set("parameters/Attack/blend_position", input_vector)
		
func free_state(delta):
	#==== THE SHORT AND SIMPLE WAY
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector != Vector2.ZERO:
		setAnimDirection(input_vector)
		animationState.travel("Run")
	else:
		animationState.travel("Idle")
		
	velocity = input_vector * WALK_SPEED
	move_and_slide(velocity)

	if Input.is_action_just_pressed("attack"):
		start_state_attack()
		
##==== THE DIRTY AND POSSIBLY MORE EFFICIENT WAY
#func free_state(delta):
#	input_vector = Vector2.ZERO
#	if Input.is_action_pressed("ui_right"):
#		direction = "Right"
#		input_vector.x += 1
#	if Input.is_action_pressed("ui_left"):
#		direction = "Left"
#		input_vector.x -= 1
#
#	if Input.is_action_pressed("ui_up"):
#		direction = "Up"
#		input_vector.y -= 1
#	if Input.is_action_pressed("ui_down"):
#		direction = "Down"
#		input_vector.y += 1
#
#	input_vector.normalized()
#
#	if input_vector == Vector2.ZERO:
#		animationPlayer.play("Idle" + direction)
#		velocity = Vector2.ZERO
#	else:
#		animationPlayer.play("Run_" + direction)
#
#		#velocity = velocity.move_toward(input_vector * WALK_SPEED, ACCELERATION * delta)
#		velocity = input_vector * WALK_SPEED
#
#	move_and_slide(velocity)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass