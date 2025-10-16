class_name CommentContainer extends VBoxContainer

var comment_scene : PackedScene = preload("uid://5bhsi4neomru")

@export var commentors : Array[Commentor]

func _ready() -> void:
	GameManager.openEval.connect(get_eval)
	GameManager.newBlogPost.connect(_clear_comments)
	
	_clear_comments()

func _clear_comments(_bp = null):
	#Destroy all childern initally
	for n in get_children():
		n.queue_free()


func get_eval(loop : int, score : int):
	_clear_comments()
	
	#TEST choose 2 - 4 comments per post
	var num_comments = randi() % 3 + 2
	
	while(num_comments >= 0):
		
		var c : CommentInstance = comment_scene.instantiate() as CommentInstance
		
		var u : Commentor = commentors.pick_random()
		
		c.pfp.texture = u.profile_pic
		c.username.text = u.username
		var content : Comment = u.pull_comment(loop,score)
		if(content == null): print("NO VALID COMMENT")
		c.comment_box.text = content.comment_string
		
		await get_tree().create_timer(randf() * .75).timeout
		
		add_child(c)
		
		num_comments -= 1
