#name GameManager used in Globals
extends Node

signal newBlogPost(bp : BlogPost)

var _sequence : Sequence = preload("uid://b6xhx4uhti62q").instantiate()

var current_loop : int = 0 

enum STATE
{
	INITIAL,
	GHOST,
	POST,
	EVAL
}

var current_state : STATE = STATE.INITIAL

func _process(delta: float) -> void:
	if(current_state == STATE.INITIAL):
		#TEST
		current_state = STATE.POST
		newBlogPost.emit(_sequence.post_queue[current_loop])
