extends VBoxContainer

@export var post_pic : TextureRect

var line_scene = preload("uid://bdwc8l0npxyfu")
var current_post : BlogPost
var line_list : Array[String]
var line_textboxes : Array[RichTextLabel]
var current_line : int = 0 
var current_line_end : int 
var eval_list : Array[int]

var current_index = 0

const grey_hex = "#6F7378"
const white_hex = "#f8f8ff"

func _ready() -> void: 
	GameManager.newBlogPost.connect(_pull_post)
	GameManager.submitPost.connect(evaluate_post_progress)

func _pull_post(post : BlogPost):
	#Destroy all childern
	for n in get_children():
		n.queue_free()
	
	line_textboxes.clear()
	line_list.clear()
	
	post_pic.texture = post.picture
	
	current_post = post
	
	line_list = post.parseString()
	
	for line in line_list:
		var inst = line_scene.instantiate()
		inst.text = "[color=%s]%s[/color]" % [grey_hex , line]
		line_textboxes.push_back(inst)
		add_child(inst)
		
	#load first line for eval
	_load_line(0)


func _input(event: InputEvent) -> void:
	if(GameManager.current_state != GameManager.STATE.POST): return
	
	if(event is InputEventKey and event.pressed and event.echo == false): 
		var unicode: int
		if not event.shift_pressed:
			unicode = event.keycode | 0x20
		else:
			unicode = event.keycode
		if unicode > 20 and unicode < 40_000: # filters most control characters
			var letter := String.chr(unicode)
			if(check_input(letter)):
				AudioController.play_key_press()
				update_line_visual()
				check_if_done()


func _load_line(line_index : int):
	current_line = line_index
	
	#reset previous variables
	current_index = 0
	eval_list.clear()
	
	var line = line_list[current_line]
	current_line_end = line.length()
	
	for char in line:
		var code
		if(is_alphanumeric(char)):
			code = 0
		else: 
			code = 3
		eval_list.push_back(code)
	
	pass

func is_alphanumeric(char :String) ->bool:
	var ascii = char.to_ascii_buffer()[0]
	if((ascii > 64 && ascii < 91) || (ascii > 47 && ascii < 58) || (ascii > 96 && ascii < 123)):
		return true
	return false

func check_input(char : String) ->bool :
	if(!is_alphanumeric(char)): print("DID NOT TYPE LETTER SOMEHOW")
	if(current_line >= line_list.size()): return false
	
	var line = line_list[current_line]

	#check if the current index is the character
	if(line[current_index] == char):
		eval_list[current_index] = 1
		return true

	#search the remaining parts of the line for the character
	var i = current_index
	var end = line.length()
	
	while(i < end):
		var c = line[i]
		#check if it's even a valid character
		if(eval_list[i] != 0): 
			i += 1
			continue
		
		#check if it's the correct character TODO add capitalization agnostic
		if(c == char || c.to_lower() == char):
			eval_list[i] = 1
			return true
		
		i += 1
	
	#if there was no match
	return false

func check_if_done():
	
	while(eval_list[current_index] > 0):
		current_index += 1
		if(current_index >= current_line_end):
			#TEST
			print("finished the line")
			GameManager.finishedLine.emit((float(current_line) + 1) / line_list.size())
			current_line += 1
			if(current_line < line_list.size()):
				_load_line(current_line)
			else:
				#send signal that post was complete
				#TEST
				print("completed post")
				GameManager.finishedPost.emit()
			return
		
	pass

func update_line_visual():
	#build the visual line from scratch, we'll see if this is performant :/
	var line = line_list[current_line]
	var box = line_textboxes[current_line]
	
	var t : String
	var i = 0
	
	while(i < current_line_end):
		var color 
		match(eval_list[i]):
			0: color = grey_hex
			1: color = white_hex
			3: 
				t += line[i]
				i += 1
				continue 
		t += "[color=%s]%s[/color]"  % [color, line[i]]
		i += 1
	
	box.text = t

func evaluate_post_progress(finished : bool = false):
	if(finished):
		GameManager.completePost.emit(100)
		return
		
	#TODO:evaluate score based on percentage of lines completed weighted by word count?
	var score = float(current_line)/line_list.size() * 100
	GameManager.completePost.emit(score)
