class_name Conversation extends Resource

@export var lines : Array[ConvoLine]

var current_line = 0

func next_line()->ConvoLine:
	
	current_line += 1
	
	if(current_line >= lines.size()):
		#TODO mark end of convo
		GameManager.completeConvo.emit()
		return null
	
	return lines[current_line]
	
