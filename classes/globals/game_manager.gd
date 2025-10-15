#name GameManager used in Globals
extends Node

signal newBlogPost(bp : BlogPost)
signal finishedPost()
signal postFailed()
signal completePost(score : int)
signal openConvo(cn : Conversation)
signal completeConvo()
signal openEval(loop : int , score : int)
signal completeLoop()

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
	completeLoop.connect(_loop)

func _post_convo():
	current_state = STATE.GHOST
	openConvo.emit(_sequence.convo_queue[current_loop])

func _blog_post():
	current_state = STATE.POST
	newBlogPost.emit(_sequence.post_queue[current_loop])
	
	if((OS.has_feature("web_android")||OS.has_feature("web_ios"))):
		DisplayServer.virtual_keyboard_show("")
	
func _post_score(score : int):
	if(loop_scores.size()-1 < current_loop):
		loop_scores.push_back(score)
	else:
		print("trying to add a score for a round that exists :(")
	
	print("earned score %s for the %s round" % [score,current_loop]) 
	
	if((OS.has_feature("web_android")||OS.has_feature("web_ios"))):
		DisplayServer.virtual_keyboard_hide()
	current_state = STATE.EVAL
	openEval.emit(current_loop,score)

func _loop():
	current_loop += 1
	if(current_loop < _sequence.total_loops):
		_post_convo()
	else:
		#end the game :)
		print("GAME OVER BAYBEE")

func _process(delta: float) -> void:
	if(current_state == STATE.INITIAL):
		_post_convo()
		
