class_name Sequence extends Node

@export var total_loops : int = 3
@export var post_queue : Array[BlogPost]
@export var convo_queue : Array[Conversation]

#do similar queues for ghost comments and evaluations?

func _ready() -> void:
	GameManager.reset.connect(_reset)
	
func _reset(): 
	for c in convo_queue:
		c.current_line = 0
