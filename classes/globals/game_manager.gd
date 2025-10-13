#name GameManager used in Globals
extends Node

signal newBlogPost(bp : BlogPost)
signal completedPost()
signal postFailed()

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

func post_score(score : int):
	if(loop_scores.size()-1 < current_loop):
		loop_scores.push_back(score)
	else:
		print("trying to add a score for a round that exists :(")
	
	print("earned score %s for the %s round" % [score,current_loop]) 
	
	current_state = STATE.EVAL

func _process(delta: float) -> void:
	if(current_state == STATE.INITIAL):
		#TEST
		current_state = STATE.POST
		newBlogPost.emit(_sequence.post_queue[current_loop])
