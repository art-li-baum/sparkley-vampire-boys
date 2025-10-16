class_name ConvoBox extends RichTextLabel

@export var animator : AnimationPlayer

func open_line(line : ConvoLine):
	text = line.line_text
	
	animator.play("read_text")

func speak():
	AudioController.play_ghost_noise()
