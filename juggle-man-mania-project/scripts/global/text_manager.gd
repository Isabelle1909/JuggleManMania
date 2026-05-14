extends Node

var json_path = "res://data/test_json.json"
var last_called


var tb
var hm
var rs
var jfl
var jfr

var talked_to_nums = {
	"wardrobe": 0,
	"mirror": 0,
	"bed": 0,
	"computer": 0,
	"tutorial": 0
}

var talked_cutscene_nums = {
	"0" : 2,
	"1": 1,
	"2": 1,
	"3": 1
	
}

var all_text = {}

func _ready():
	load_json_file()
	display_text("mirror")

func load_json_file():
	#open file for reading
	var file = FileAccess.open(json_path, FileAccess.READ)
	#check if file exists
	assert(file.file_exists(json_path), "File path does not exist")
	
	# Read the contents of the file as text
	var json = file.get_as_text()
	var json_object = JSON.new()
	
	#parse the JSON text
	json_object.parse(json)
	#Store the parsed data in the content dictionary
	all_text = json_object.data


#called on interaction with object, which passes it's name
func display_text(ob_name):
	if tb == null || hm ==null|| rs == null:
		return
	if hm.visible || rs.visible:
		return
	tb.visible = true
	#increments the objects talk_to number
	
	if talked_to_nums.has(ob_name):
		#gets the correct text from the json file depending on object, time/day and number of 
		#times it's been spoken to
		var path_string = str(SystemManager.time,"_",SystemManager.day,"_",SystemManager.mood)
		print(talked_to_nums[ob_name], " ", ob_name)
		talked_to_nums[ob_name] += 1
		if !check_valid(ob_name,path_string,str(talked_to_nums[ob_name]),tb):
			talked_to_nums[ob_name] -= 1
			check_valid(ob_name,path_string,str(talked_to_nums[ob_name]),tb)
		
		#will use text box UI to display later for now prints to console

func check_valid(ob_name, path_string,line,bx) -> bool:
	if all_text.has(ob_name):
		if all_text[ob_name].has(path_string):
			if all_text[ob_name][path_string].has(line):
				var text = all_text[ob_name][path_string][line]
				print("found ", text)
				bx.get_node("Panel/RichTextLabel").text = text
				return true
			else:
				print("line not found")
		else:
			print("section not found")
	else:
		print("object not found")
	return false
	

func display_cutscene_text(scene_name,section,line,box):
	if box == null:
		print("dont exist")
		return
	box.visible = true
	if talked_cutscene_nums.has(section):
		check_valid(scene_name,section,line,box)
		



func close_text(ob_name, bx):
		print("close_text")
		bx.visible = false
		


func show_juggling_feedback(timing,side):
	var box
	
	if jfl == null || jfr == null:
		return
	
	if side.contains("left"):
		box = jfl
	elif side.contains("right"):
		box = jfr
	
	if timing.contains("early"):
		box.visible = true
		box.text = "Early!"
	elif timing.contains("perfect"):
		box.visible = true
		box.text = "Perfect!"
	elif timing.contains("late"):
		box.visible = true
		box.text = "Late!"


func hide_juggling_feedback():
	if jfl == null || jfr == null:
		return
	jfl.visible = false
	jfr.visible = false
