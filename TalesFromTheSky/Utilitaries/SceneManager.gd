extends Node2D

signal scene_unloaded
signal scene_loaded

onready var _tree = get_tree()
onready var transition_fade = $CanvasLayer/SceneTransitionRect
onready var current_scene: Map = _tree.current_scene
onready var limbo = $Limbo

# Called when the node enters the scene tree for the first time.
func _ready():
	print("> SceneManager Ready")

func _enter_tree():
	print("> SceneManager enters tree")

func test():
	print("Singleton Test")

#TODO changer le moment où la scene est chargée
func change_scene(path) -> void:
	transition_fade.start_transition()
	yield(transition_fade, "transition_middle")
	_replace_scene(path)

static func load_map(path: String) -> Map:
	var map_scene = ResourceLoader.load(path)
	var map =  map_scene.instance()
	assert(map is Map, "The root node of the loaded scene is not a Map")
	return map

func _replace_scene(path: String) -> void:
	print("> Initiating scene change")
	
	emit_signal("scene_unloaded")
	var new_scene = load_map(path)
	_tree.current_scene.queue_free()
	
	yield(_tree, "idle_frame")
	
	print("> Swapping scenes")
	current_scene = new_scene
	_tree.get_root().add_child(current_scene)
	_tree.set_current_scene(current_scene)
	
	emit_signal("scene_loaded")
	
	for node in limbo.get_children():
		limbo.remove_child(node)
		
func enter_limbo(node: Node) -> void:
	node.get_parent().remove_child(node)
	limbo.add_child(node)
	print(node.get_parent())
