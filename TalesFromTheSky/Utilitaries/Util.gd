class_name Util

static func is_same_direction4(dir1: Vector2, dir2: Vector2)->bool:
	return abs(dir1.angle_to(dir2)) < PI / 4
	
static func is_similar_direction4(dir1: Vector2, dir2: Vector2)->bool:
	return dir1.dot(dir2) > 0

static func test():
	print("Oui")
