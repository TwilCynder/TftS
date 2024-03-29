extends Node2D

var CutEffect = load("res://Effects/GrassCut.tscn")
var Hitbox = load("res://Overlap/Hitbox.gd")

func create_cut_effect():
	EffectManager.add_effect_to(get_parent(), CutEffect, position)

func _process(delta):
	pass

func _on_Hurtbox_hit(hitbox: Hitbox, hurtbox: Hurtbox):
	if (hitbox.hitboxType == hitbox.HitboxType.SWORD):
		create_cut_effect()
		queue_free()
