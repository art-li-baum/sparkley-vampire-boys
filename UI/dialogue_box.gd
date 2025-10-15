class_name DialogueBox extends RichTextLabel

@export var animator : AnimationPlayer

func read_text(message : String):
	
	text = message
	animator.play("read_text")
