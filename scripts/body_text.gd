extends RichTextLabel

var main_scene

func _ready() -> void: 
	print("i remember how to code in godot!")
	
	main_scene = self.owner
	print(main_scene)
	
	# connect signal
	main_scene.go_next_post.connect(go_next_post)

	var first_text = main_scene.blog_posts[0].blog_text
	print(first_text)
	set_text(first_text)
	
#func _process(delta) -> void:
	
func go_next_post() -> void:
	print("NEXT POST!")
	set_text(main_scene.get_current_text())
	pass
