#name GameManager used in Globals
extends Node

signal newBlogPost(bp : BlogPost)
signal finishedPost()
signal postFailed()
signal completePost(score : int)
signal openConvo(cn : Conversation)
signal completeConvo()

var _sequence : Sequence = preload("uid://b6xhx4uhti62q").instantiate()

var current_loop : int = 0 

var loop_scores : Array[int] = []

enum STATE
{
	INITIAL,
	GHOST,
	POST,
	EVAL
}

var current_state : STATE = STATE.INITIAL

func _ready() -> void:
	completeConvo.connect(_blog_post)
	completePost.connect(_post_score)
	

func _post_convo():
	current_state = STATE.GHOST
	openConvo.emit(_sequence.convo_queue[current_loop])

func _blog_post():
	current_state = STATE.POST
	newBlogPost.emit(_sequence.post_queue[current_loop])
	
func _post_score(score : int):
	if(loop_scores.size()-1 < current_loop):
		loop_scores.push_back(score)
	else:
		print("trying to add a score for a round that exists :(")
	
	print("earned score %s for the %s round" % [score,current_loop]) 
	
	current_state = STATE.EVAL

func _process(delta: float) -> void:
	if(current_state == STATE.INITIAL):
		_post_convo()
		
