extends Skill

var IceEffect: Resource = load("res://Skills/Effects/Ice/IceEffect.tscn")

func _ready():
	print("Ice ready !")
		
func use(player: Player):
	print("Ice used !")
	var position: Vector2 = player.direction.normalized() * 16
	print(position)
	var effect = player.effect_manager.add_effect(IceEffect, position)
	
