extends Skill

var IceEffect: Resource = load("res://Skills/Effects/Ice/IceEffect.tscn")
var IceBlock: Resource = load("res://Skills/Effects/Ice/IceBlock.tscn")
var IceHitbox: Resource = load("res://Skills/Effects/Ice/Hitbox.tscn")

const tile_translation: Dictionary = {
	29: 107,
	28: 105,
	54: 100,
	41: 101,
	45: 102,
	37: 103
}

const delay = 5

func _ready():
	print("Ice ready !")
		
func display_effect(player: Player, position: Vector2) :
	var effect = player.add_effect_to_parent(IceEffect, position)
	effect.connect("effect_end", self, "_on_effect_finished", [player, position])		
	
const displacements: Array = [
	(Vector2.LEFT + Vector2.UP) * 8,
	(Vector2.RIGHT + Vector2.UP) * 8,
	(Vector2.LEFT + Vector2.DOWN) * 8,
	(Vector2.RIGHT + Vector2.DOWN) * 8
]		
		
static func transform_ice_tiles_(tilemap: TileMap, position: Vector2):
	position = (position - tilemap.global_position)
	var res: bool = false
	for i in range(0, 4):
		if transform_ice_tile(tilemap, position + displacements[i]):
			res = true
	return res
		
static func transform_ice_tile(tilemap: TileMap, position: Vector2) -> bool:
	position = position/16
	var cell: int = tilemap.get_cellv(position)
	var ice_tile = tile_translation.get(cell)
	if ice_tile != null:
		tilemap.set_cellv(position, ice_tile)
		return true
	return false
	
func _create_block(player: Player, position: Vector2):
	player.instance_on_parent(IceBlock, position)	
	
func transform_ice_tiles(player: Player, position: Vector2):
	var res: bool = false
	if player.layer is Layer:
		var layer: Layer = player.layer as Layer
		for tilemap in layer.get_tilemaps():
			res = res or transform_ice_tiles_(tilemap, player.global_position + position)
	return res

var effect_hitbox: Hitbox = null

func freeze_enemies(player: Player, position: Vector2) -> bool:
	var hitbox: Hitbox = IceHitbox.instance()
	
	player.add_child(hitbox)
	hitbox.position = position
	
	remove_hitbox()
	effect_hitbox = hitbox
		
	return false

func use(player: Player):
	print("Ice used !")
	
	var position: Vector2 = player.direction.normalized() * 16
	
	if not (transform_ice_tiles(player, position) or freeze_enemies(player, position)):
		_create_block(player, position)
	display_effect(player, position)
	
func remove_hitbox():
	if effect_hitbox and (effect_hitbox is Hitbox) and effect_hitbox.is_inside_tree():
		effect_hitbox.queue_free()	
	
func on_end(player: Player):
	remove_hitbox()
	effect_hitbox = null
	.on_end(player)

	
func _on_effect_finished(player: Player, position: Vector2):
	end(player)
