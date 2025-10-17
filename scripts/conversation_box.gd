class_name ConvoBox extends RichTextLabel

@export var animator : AnimationPlayer

var tone : float

func open_line(line : ConvoLine):
	text = line.line_text
	
	animator.speed_scale = line.text_read_speed
	tone = line.tone_pitch
	
	animator.play("read_text")

func speak():
	AudioController.play_ghost_noise(tone)
