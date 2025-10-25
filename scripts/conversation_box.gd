class_name ConvoBox extends RichTextLabel

@export var animator : AnimationPlayer
@export var next_button: Control

var tone : float

func open_line(line : ConvoLine):
	text = line.line_text
	
	animator.speed_scale = line.text_read_speed
	tone = line.tone_pitch
	
	next_button.release_focus()
	
	animator.play("read_text")

func speak():
	AudioController.play_ghost_noise(tone)

func next():
	next_button.grab_focus()
