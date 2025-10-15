class_name Commentor extends Resource

@export var profile_pic : CompressedTexture2D 
@export var username : String

@export var comments : Array[Comment]

var is_sorted : bool = false
var sorted_comments : Dictionary

func pull_comment(loop : int, score : int) -> Comment:
	if(!is_sorted): _sort_comments()
	
	var comment_pool : Array[Comment]
	if(sorted_comments.has(loop)):
		#pick from the list from that 
		comment_pool = sorted_comments[loop]
	else:
		comment_pool = sorted_comments[-1]
	
	#pull a random comment from the pool
	var found = false
	var comment : Comment
	while(!found):
		comment = comment_pool.pick_random()
		if(score >= comment.score_range.x && score <= comment.score_range.y):
			found = true
			return comment
	
	return null 

func _sort_comments():
	sorted_comments.clear()
	
	for comment in comments:
		if(sorted_comments.has(comment.specific_post)):
			sorted_comments[comment.specific_post].push_back(comment)
		else:
			var array : Array[Comment] = [comment]
			sorted_comments.get_or_add(comment.specific_post,array)
	
	is_sorted = true
