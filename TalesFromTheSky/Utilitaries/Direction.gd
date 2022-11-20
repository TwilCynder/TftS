class_name Direction

enum {
	RIGHT,
	UP,
	LEFT,
	DOWN
}

enum dirs {
	RIGHT,
	UP,
	LEFT,
	DOWN
}

const directions_names = [
	"right",
	"up",
	"left",
	"down"
]

static func is_same_direction4(dir1: Vector2, dir2: Vector2)->bool:
	return abs(dir1.angle_to(dir2)) < PI / 4
	
static func is_similar_direction4(dir1: Vector2, dir2: Vector2)->bool:
	return dir1.dot(dir2) > 0

static func vector_to_direction4(vec: Vector2) -> int:
	var x = abs(vec.x)
	var y = abs(vec.y)
	
	if x > y:
		return RIGHT if x > 0 else LEFT
	else:
		return UP if y > 0 else DOWN

static func direction4_to_vector():
	pass

static func direction4_to_directionName(direction: int)->String:
	return directions_names[direction]

static func direction4_to_directionName_assert(direction: int)->String:
	assert(direction >= 0 and direction < 4)
	return direction4_to_directionName(direction)
