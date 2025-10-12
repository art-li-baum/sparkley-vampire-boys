class_name blogpost
extends Resource

@export_multiline var blog_text: String

@export var line_length: int = 50

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
	
