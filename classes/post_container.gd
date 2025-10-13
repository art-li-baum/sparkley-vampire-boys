extends VBoxContainer

var line_scene = preload("uid://bdwc8l0npxyfu")
var current_post : BlogPost
var line_list : Array[String]
var line_textboxes : Array[RichTextLabel]
var current_line : int = 0 

const grey_hex = "#6F7378"

func _ready() -> void: 
	GameManager.newBlogPost.connect(_pull_post)

func _pull_post(post : BlogPost):
	#Destroy all childern
	for n in get_children():
		n.queue_free()
	
	current_post = post
	
	line_list = post.parseString()
	
	for line in line_list:
		var inst = line_scene.instantiate()
		inst.text = "[color=%s]%s[/color]" % [grey_hex , line]
		line_textboxes.push_back(inst)
		add_child(inst)
	
	#TODO: Set post timer
	
	#TODO: load first line for eval


		
func _input(event: InputEvent) -> void:
	if(event is InputEventKey and event.pressed and event.echo == false): 
		var unicode: int
		if not event.shift_pressed:
			unicode = event.keycode | 0x20
		else:
			unicode = event.keycode
		if unicode > 20 and unicode < 40_000: # filters most control characters
			var letter := String.chr(unicode)
			print(letter)
