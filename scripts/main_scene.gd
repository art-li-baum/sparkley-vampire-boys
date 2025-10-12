extends Control

@export var blog_posts: Array[blogpost] = []
var current_post: int = 0;

signal go_next_post

func get_current_post() -> blogpost:
	if(current_post < blog_posts.size()):
		return blog_posts[current_post]
	else:
		# TODO: implement, like, actual game end state
		# until then im just doing this so it doesnt just BREAK hadlfkdf
		return blog_posts.back()

func get_current_text() -> String:
	return get_current_post().blog_text

func _on_button_next_pressed() -> void:
	current_post += 1;
	go_next_post.emit() 
	# i think this is like, a reasonable thing to set up to avoid race conditions
	# instead of tying everything to the button signal??
