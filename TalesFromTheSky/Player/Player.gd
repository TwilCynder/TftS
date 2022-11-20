extends MapEntity

enum {
	FREE,
	ATTACK,
	KNOCKBACK
}

class_name Player

signal interact()

export(bool) var allow_redundancy = false #If unchecked, delete the hero if there is another on the same Map ? (typically on maps with Auto Hero)
export(bool) var use_as_default_destination = true #If checked, will

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/Swordhitbox
onready var collisionBox = $CollisionBox

var TreeUtil = load("res://Utilitaries/TreeUtil.gd")

func _enter_tree():
	print("> Player enter tree")

			
func _ready():
	print("> Hello there ! (Player ready)")
	
	var root = SceneManager.current_scene
	#assert(root != null, "Can't find root node")
	if root is Map:	
		if root.get_hero():
			if not allow_redundancy:
				print("> Deleting this Player because the map already has a hero")
				get_parent().remove_child(self)
				queue_free()
		else:
			root.set_hero(self)
	
	animationTree.active = true
	
const WALK_SPEED: int = 100
const ACCELERATION: int = 200
const traction: int = 3000

var state = FREE
var velocity = Vector2.ZERO #Current move speed (input_vector * WALK_SPEED when moving in FREE state)
var input_vector = Vector2.ZERO 
var direction: Vector2 = Vector2.RIGHT #last non-zero value input_vector had in FREE state
#var direction = "Right"

func is_looking_at(point: Vector2)->bool:
	return Direction.is_same_direction4(direction, point - global_position)

func is_looking_towards(point: Vector2)->bool:
	return Direction.is_similar_direction4(direction, point - global_position)

func start_state_attack():
	setAnimation("Attack")
	swordHitbox.knockback = direction

func start_state_free():
	pass
	
func start_state_knockback():
	setAnimation("HurtLeft")

func attack_animation_finished():
	setState(FREE)
	swordHitbox.knockback = null

func exit_state_free():
	pass
	
func exit_state_attack():
	swordHitbox.set_enabled(false)
	
func exit_state_knockback():
	pass
	
func exit_current_state():
	match state:
		FREE:
			exit_state_free()
		ATTACK:
			exit_state_attack()
		KNOCKBACK:
			exit_state_knockback()

func setState(state_):
	match state_:
		FREE:
			start_state_free()
		ATTACK:
			start_state_attack()
		KNOCKBACK:
			start_state_knockback()
			
	state = state_

func _process(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		SceneManager.on_hero_interact(self)

func _physics_process(delta: float):
	match state:
		FREE:	
			free_state(delta)
		ATTACK:
			attack_state(delta)
		KNOCKBACK:
			knockback_state(delta)
		
func attack_state(delta):
	pass
		
func setAnimation(anim: String):
	animationState.travel(anim)
	animationTree.set("parameters/" + anim + "/blend_position", direction)
		
func setAnimDirection(input_vector):
	animationTree.set("parameters/Idle/blend_position", input_vector)
	animationTree.set("parameters/Run/blend_position", input_vector)
	animationTree.set("parameters/Attack/blend_position", input_vector)
		
func knockback_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, traction * delta)
	if velocity == Vector2.ZERO:
		setState(FREE)
		return
			
	velocity = move_and_slide(velocity)
		
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
		setState(ATTACK)
		
func get_direction()->Vector2:
	return direction
		
func _on_Hurtbox_hit(hitbox: Hitbox, hurtbox: Hurtbox):
	var knockback: Vector2 = hitbox.computeEffectiveKnockback(hurtbox.global_position)
	velocity = knockback
	setState(KNOCKBACK)
