class_name ConvoBox extends RichTextLabel

@export var animator : AnimationPlayer

func open_line(line : ConvoLine):
	text = line.line_text
	
	#TODO this is busted for some reason?
	animator.play("read_text")
