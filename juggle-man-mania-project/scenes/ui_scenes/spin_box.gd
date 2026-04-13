extends SpinBox

func saveObject() -> Dictionary:
	var dict := {
		"filepath": get_path(),
		"savedInt": var_to_str(value)
	}
	return dict 

func loadObject(loadedDict: Dictionary) -> void:
	value = str_to_var(loadedDict.savedInt)
