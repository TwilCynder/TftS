extends Skill

var IceEffect: Resource = load("res://Skills/Effects/Ice/IceEffect.tscn")
var IceBlock: Resource = load("res://Skills/Effects/Ice/IceBlock.tscn")

func _ready():
	print("Ice ready !")
		
func display_effect(player: Player, position: Vector2):
	var effect = player.add_effect_to_parent(IceEffect, position)
	effect.connect("effect_end", self, "_on_effect_finished", [player, position])
		
static func transform_ice_tile(tilemap: TileMap, position: Vector2):
	position = position - tilemap.global_position
	print(tilemap.get_cell(position.x / 16, position.y / 16))
	
func use(player: Player):
	print("Ice used !")
	var position: Vector2 = player.direction.normalized() * 16
	player.instance_on_parent(IceBlock, position)
	display_effect(player, position)
	if player.get_parent() is Layer:
		var layer: Layer = player.get_parent() as Layer
		for tilemap in layer.get_tilemaps():
			transform_ice_tile(tilemap, player.global_position + position)
	
	
	
func _on_effect_finished(player: Player, position: Vector2):
	player.end_skill()
