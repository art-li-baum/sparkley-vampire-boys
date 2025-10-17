class_name DialogueBox extends RichTextLabel

@export var animator : AnimationPlayer

func _ready() -> void:
	GameManager.openConvo.connect(continuity)


func read_text(message : String):
	
	text = message
	animator.play("read_text")

func continuity( convo :  Conversation):
	text = convo.lines.back().line_text

func speak():
	AudioController.play_ghost_noise()
