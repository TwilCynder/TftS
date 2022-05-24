class_name TreeUtil

static func get_current_map(tree: SceneTree) -> Map:
	var map = tree.root.get_child(tree.root.get_child_count() - 1)
	if (map is Map):
		return map
	return null
