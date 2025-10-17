class_name GhostDialogue extends Control

@export var dialogue_box : DialogueBox
@export var header: RichTextLabel

func _ready() -> void:
	GameManager.openEval.connect(react_eval)
	GameManager.finishedLine.connect(quip)

func react_eval(loop: int, score:int):
	
	#TODO: Quip about score
	match(loop):
		_ : 
			dialogue_box.read_text("Look at all those comments!")
			header.text = "WoWeee :0"

func quip(completion : float):
	
	#TODO: have a random chance to encourage/ egg on the player 
	if(randf() > 0.5):
		dialogue_box.read_text("Look at you go!")
