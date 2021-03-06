extends KinematicBody2D

enum {
	FREE,
	ATTACK
}

class_name Player

export(bool) var allow_redundancy = false #If unchecked, delete the hero if there is another on the same Map ? (typically on maps with Auto Hero)
export(bool) var use_as_default_destination = true #If checked, will

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/Swordhitbox

var Map = load("res://Scripts/Map.gd")
var TreeUtil = load("res://Utilitaries/TreeUtil.gd")

func _enter_tree():
	print("> Player enter tree")

			
func _ready():
	print("> Hello there ! (Player ready)")
	
	var root = SceneManager.current_scene
	assert(root != null, "Can't find root node")
	if root.get_hero():
		if not allow_redundancy:
			print("> Deleting this Player because the map already has a hero")
			get_parent().remove_child(self)
			queue_free()
	else:
		root.set_hero(self)
	
	animationTree.active = true
	
	

const WALK_SPEED = 100
var ACCELERATION = 200

var state = FREE
var velocity = Vector2.ZERO #Current move speed (input_vector * WALK_SPEED when moving in FREE state)
var input_vector = Vector2.ZERO 
var direction: Vector2 = Vector2.ZERO #last non-zero value input_vector had in FREE state
#var direction = "Right"

func start_state_attack():
	state = ATTACK
	setAnimation("Attack")
	swordHitbox.knockback = direction

func start_state_free():
	state = FREE

func attack_animation_finished():
	start_state_free()
	swordHitbox.knockback = null

func _physics_process(delta):
	match state:
		FREE:	
			free_state(delta)
		ATTACK:
			attack_state(delta)
		
func attack_state(delta):
	pass
		
func setAnimation(anim: String):
	animationState.travel(anim)
	animationTree.set("parameters/" + anim + "/blend_position", direction)
		
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
		direction = input_vector
		setAnimation("Run")
	else:
		setAnimation("Idle")
		
	velocity = input_vector * WALK_SPEED
	move_and_slide(velocity)

	if Input.is_action_just_pressed("attack"):
		start_state_attack()
		
##==== THE DIRTY AND POSSIBLY MORE EFFICIENT WAY (ok i don't think it is)
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
