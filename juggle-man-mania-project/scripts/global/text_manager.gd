extends Node

var json_path = "res://data/test_json.json"
var last_called


var tb
var hm
var rs
var ynb
var jfl
var jfr

var talked_to_nums = {
	"wardrobe": 0,
	"mirror": 0,
	"bed": 0,
	"computer": 0,
	"tutorial": 0,
	"dirty_laundry": 0,
	"bookshelf": 0,
	"fridge": 0,
	"couch": 0,
	"toilet": 0,
	"messy_desk":0,
	"shower": 0,
	"tv":0,
	"oven":0,
	
}

var talked_cutscene_nums = {
	"-1": 2,
	"0": 1,
	"1": 1,
	"2": 2,
	"3": 1,
	"4": 1,
	"undress": 0,
	"dress": 0,
	"stay": 0,
	"smoke": 0,
	"dress_practice":0,
	"ending_1": 6,
	"ending_2": 9,
	"ending_3": 26
	
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
				print(line)
		else:
			print("section not found")
			print(path_string)
	else:
		print("object not found")
		print(ob_name)
	return false
	

func display_cutscene_text(scene_name,section,line,box):
	if box == null:
		box = tb
	box.visible = true
	if talked_cutscene_nums.has(str(section)) && line != null:
		check_valid(scene_name,str(section),str(line),box)
	elif talked_cutscene_nums.has(section):
		talked_cutscene_nums[section] += 1
		if !check_valid(scene_name,str(section),str(talked_cutscene_nums[section]),box):
			talked_cutscene_nums[section] -= 1
			check_valid(scene_name,str(section),str(talked_cutscene_nums[section]),box)
		

func question_text(question):
	var box = tb
	if box != null && ynb != null:
		box.visible = true
		box.get_node("Panel/RichTextLabel").text = question
		ynb.visible = true
		ynb.redirect_focus()

func close_question():
	var box = tb
	if box != null && ynb != null:
		box.visible = false
		ynb.visible = false

func close_text(bx):
		print("close_text")
		if bx == null:
			bx = tb
		bx.visible = false
		


func show_juggling_feedback(timing,side):
	var box
	var box_text
	
	if jfl == null || jfr == null:
		return
	
	if side.contains("left"):
		box = jfl
		box_text = jfl.get_node("left_feedback")
	elif side.contains("right"):
		box = jfr
		box_text = jfr.get_node("right_feedback")
	
	if timing.contains("early"):
		box.visible = true
		box_text.text = "Early!"
	elif timing.contains("perfect"):
		box.visible = true
		box_text.text = "Perfect!"
	elif timing.contains("late"):
		box.visible = true
		box_text.text = "Late!"


func hide_juggling_feedback():
	if jfl == null || jfr == null:
		return
	jfl.visible = false
	jfr.visible = false
