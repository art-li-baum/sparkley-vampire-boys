class_name GhostDialogue extends Control

@export var dialogue_box : DialogueBox
@export var header: RichTextLabel

func _ready() -> void:
	GameManager.openEval.connect(react_eval)

func react_eval(loop: int, score:int):
	
	match(loop):
		_ : 
			dialogue_box.read_text("Look at all those comments!")
			header.text = "WoWeee :0"
