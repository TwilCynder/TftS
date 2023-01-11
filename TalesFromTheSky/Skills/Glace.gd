extends Skill

var IceEffect: Resource = load("res://Skills/Effects/Ice/IceEffect.tscn")

func _ready():
	print("Ice ready !")
		
func use(player: Player):
	print("Ice used !")
	var position: Vector2 = player.direction.normalized() * 16
	var effect = player.effect_manager.add_effect(IceEffect, position)
	effect.connect("effect_end", self, "_on_finished", [player])
	
func _on_finished(player: Player):
	player.end_skill()
