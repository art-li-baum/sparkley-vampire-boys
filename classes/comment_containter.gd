class_name CommentContainer extends VBoxContainer

var comment_scene : PackedScene = preload("uid://5bhsi4neomru")

@export var commentors : Array[Commentor]
@export var core_commentors: Array[Commentor]

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
	
	var num_rand_comments = 0
	var num_core_comments = 0
	
	match(loop):
		0: #intro
			num_rand_comments = 1
			num_core_comments = 3
		1: #spike
			num_rand_comments = randi() % 2 + 2
			num_core_comments = randi() % 2 + 2
		2: #viral
			num_rand_comments = randi() % 2 + 4
			num_core_comments = randi() % 2 + 1
		3: #over stimulated
			num_rand_comments = randi() % 4 + 4
			num_core_comments = randi() % 2 + 2
		4: #crashout
			num_rand_comments = randi() % 2 + 1
			num_core_comments = randi() % 2 + 2
		5: #retcon
			num_core_comments = 3
		6: #conclusiom
			num_rand_comments = randi() % 2 + 1
			num_core_comments = 3
	
	
	while(num_rand_comments >= 0 && num_core_comments >=0):
		
		var c : CommentInstance = comment_scene.instantiate() as CommentInstance
		
		var u : Commentor 
		if(num_core_comments <= 0):
			u = commentors.pick_random()
			num_rand_comments -= 1
		elif(num_rand_comments <= 0):
			u = core_commentors[num_core_comments - 1]
			num_core_comments -= 1
		elif(randi() % 2):
			u = commentors.pick_random()
			num_rand_comments -= 1
		else:
			u = core_commentors[num_core_comments - 1]
			num_core_comments -= 1
		
		c.pfp.texture = u.profile_pic
		c.username.text = u.username
		var content : Comment = u.pull_comment(loop,score)
		if(content == null): print("NO VALID COMMENT")
		c.comment_box.text = content.comment_string
		
		await get_tree().create_timer(randf() * .75).timeout
		
		AudioController.play_pop_noise()
		add_child(c)
		
		
