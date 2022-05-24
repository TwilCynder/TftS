extends Node2D

signal scene_unloaded

onready var _tree = get_tree()

# Called when the node enters the scene tree for the first time.
func _ready():
	print("> SceneManager Ready")

func test():
	print("Singleton Test")

func change_scene(path: String) -> void:
	print("Change scene")
	_tree.current_scene.queue_free()
	
	emit_signal("scene_unloaded")
	var following_scene = ResourceLoader.load(path)
	var current_scene = following_scene.instance()
	
	yield(_tree, "idle_frame")
	
	_tree.get_root().add_child(current_scene)
	_tree.set_current_scene(current_scene)
