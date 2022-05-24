extends ColorRect

signal transition_middle

func start_transition():
	$AnimationPlayer.play("Fade_to_black")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("transition_middle")
	$AnimationPlayer.play("Fade_to_normal")

func _ready():
	#start_transition()
	pass
