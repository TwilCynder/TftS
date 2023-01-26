class_name TreeUtil

static func get_current_map(tree: SceneTree) -> Map:
	var map = tree.root.get_child(tree.root.get_child_count() - 1)
	if (map is Map):
		return map
	return null

static func move_node_above(node1: Node, node2: Node):
	var parent: Node = node1.get_parent()
	var position: int = node2.get_position_in_parent()
	parent.move_child(node1, position)
