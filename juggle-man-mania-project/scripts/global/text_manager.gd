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
	"computer": 0
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
	
	
	#print(ob_name)
	#print(talked_to_nums.has(ob_name))
	if talked_to_nums.has(ob_name):
		if talked_to_nums[ob_name] < 3:
			talked_to_nums[ob_name] += 1
			print(talked_to_nums[ob_name])
	
		#gets the correct text from the json file depending on object, time/day and number of 
		#times it's been spoken to
		var path_string = str(SystemManager.time,"_",SystemManager.day,"_",SystemManager.mood)
		var text = all_text[ob_name][path_string][str(talked_to_nums[ob_name])]
		print(text)
		tb.get_node("Panel/RichTextLabel").text = text
		#will use text box UI to display later for now prints to console


func close_text(ob_name):
		print("close_text")
		tb.visible = false


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
