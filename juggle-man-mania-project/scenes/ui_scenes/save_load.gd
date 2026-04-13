extends Control

func _on_save_pressed() -> void:
	_save()
	$LineEdit.clear() # clears the LineEdit after saving
	$SpinBox.value = 0 # sets SpinBox back to Zero
	
func _on_load_pressed() -> void:
	_load()
	
func _on_delete_pressed() -> void:
	DirAccess.remove_absolute("saveFile")
	print("GAME DELETED")

func _save() -> void:
	var save_file = FileAccess.open("saveFile", FileAccess.WRITE) # Open File
	
	# goes through every object in the save group
	var save_nodes = get_tree().get_nodes_in_group("SaveLoad")
	for node in save_nodes:
		# checks if the node has a save function
		if !node.has_method("saveObject"):
			print("Node '%s' is missing a save function, skipped" % node.name)
			continue
			
		# calls the node's save function
		var node_data = node.call("saveObject")
		
		# store the save dictionary as a new line in the save file
		save_file.store_line(JSON.stringify(node_data))
	
	save_file.close() #closes File
	print("GAME SAVED")

func _load() -> void:
	# checks if the SaveFile exists
	if !FileAccess.file_exists("saveFile"):
		print("Error, no Save File to load.")
		return
		
	var save_file = FileAccess.open("saveFile", FileAccess.READ) # opens file
	
	while save_file.get_position() < save_file.get_length():
		# gets the saved dictionary from the next line in the save file
		var json = JSON.new()
		json.parse(save_file.get_line())
		
		# gets the Data
		var node_data = json.get_data()
		if has_node(node_data["filepath"]):
			get_node(node_data["filepath"]).loadObject(node_data)
			
	save_file.close() # closes file
	print("GAME LOADED")
