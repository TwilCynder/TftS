tool
extends EditorImportPlugin

func get_importer_name():
	return "my.special.plugin"

func get_visible_name():
	return "Special Mesh"

func get_recognized_extensions():
	return ["png"]

func get_save_extension():
	return "fnt"

func get_resource_type():
	return "Font"

func get_preset_count():
	return 1

func get_preset_name(i):
	return "Default"

func get_import_options(i):
	return [{"name": "my_option", "default_value": false}]

func import(source_file, save_path, options, platform_variants, gen_files):
	var file = File.new()
	if file.open(source_file, File.READ) != OK:
		return FAILED

	var mesh = Mesh.new()
	# Fill the Mesh with data read in "file", left as an exercise to the reader

	var filename = save_path + "." + get_save_extension()
	return ResourceSaver.save(filename, mesh)
