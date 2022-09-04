extends Node2D

var CutEffect = load("res://Effects/GrassCut.tscn")
var Hitbox = load("res://Overlap/Hitbox.gd")

func create_cut_effect():
	var cutEffect = CutEffect.instance()
	get_parent().add_child(cutEffect)
	cutEffect.position = self.position

func _process(delta):
	pass

func _on_Hurtbox_hit(hitbox: Hitbox):
	if (hitbox.hitboxType == hitbox.HitboxType.SWORD):
		create_cut_effect()
		queue_free()
