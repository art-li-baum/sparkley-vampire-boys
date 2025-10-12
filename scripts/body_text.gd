extends RichTextLabel

var main_scene
var current_text: String
var current_line_string: String
var last_char: int = 0

func _ready() -> void: 
	print("i remember how to code in godot!")
	
	main_scene = self.owner
	
	# connect signal
	main_scene.go_next_post.connect(go_next_post)

	current_text = main_scene.blog_posts[0].blog_text
	set_text(current_text)
	
	set_first_line()

#func _process(delta) -> void:
	
func go_next_post() -> void:
	print("NEXT POST!")
	current_text = main_scene.get_current_text()
	set_text(current_text)
	set_first_line()
	pass

func set_first_line() -> void:
	last_char = current_text.rfind(" ",50)
	current_line_string = current_text.substr(0, last_char)
	print(current_line_string)

func _input(event):
	## accept key PRESSES (not RELEASES and also NOT HOLDS)
	if(event is InputEventKey and event.pressed and event.echo == false): 
		# print(event.as_text_keycode())

		# TODO: MOVE THIS OUT OF THE INPUT AREA, THIS IS JUST HERE FOR TESTING PURPOSES
		# getting lines (by finding index of last space)
		# (basically avoiding cut-off words)
		# max line length is 50 characters (+ one space)
		
		var next_index = 51 + last_char
		var next_char = current_text.rfind(" ", next_index)		
		current_line_string = current_text.substr(last_char + 1, next_char - last_char)
		print(current_line_string)
		
		last_char = next_char
		
		# TODO: handle last line correctly since it doesnt end in a spaceee
