tool
extends EditorPlugin

const plugin = preload("res://Utilitaries/FontManager/FontImporter.gd")
var import_plugin = plugin.new()

func _enter_tree():
	add_import_plugin(import_plugin)

func _exit_tree():
	remove_import_plugin(import_plugin)
