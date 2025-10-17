@tool
class_name BlogPost
extends Resource

@export_multiline var blog_text: String
@export var urgency : int = 1
@export_tool_button("Suggest", "Callable") var eval_action = eval_time
@export var time_to_write : float

@export var line_length: int = 50

@export var no_timer : bool = false

func parseString() -> Array[String]:
	var blog_string :Array[String] = []
	
#	blog_text = blog_text.c_unescape()
	
	#finds the end of the last word of the first line
	var index = blog_text.rfind(" ",line_length)
	var end_index = blog_text.length()
	
	
	#add first line
	blog_string.push_back(blog_text.substr(0,index))
	
	while(index + 1 + line_length < end_index):
		var next_window = line_length + 1 + index
		var next_index = blog_text.rfind(" ", next_window)		
		var current_line_string = blog_text.substr(index + 1, next_index - index)
		blog_string.push_back(current_line_string)
		
		index = next_index
	
	var index_dif = index + line_length + 1 - end_index
	
	if( index_dif > 0):
		var remainder = end_index - (line_length - index_dif) 
		var s = blog_text.substr(remainder)
		
		blog_string.push_back(s)
	
	return blog_string

func eval_time():
	var line_count = parseString().size()
	
	var mult 
	match(urgency):
		1 : mult = 1.2
		2 : mult = .90
		3 : mult = .75
	
	var estimate = (line_count * line_length ) / 4 * mult
	
	time_to_write = estimate
	notify_property_list_changed()

	
