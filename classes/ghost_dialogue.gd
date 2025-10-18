class_name GhostDialogue extends Control

@export var dialogue_box : DialogueBox
@export var header: RichTextLabel

func _ready() -> void:
	GameManager.openEval.connect(react_eval)
	GameManager.finishedLine.connect(quip)

func react_eval(loop: int, score:int):
	
	#TODO: Quip about score
	match(loop):
		0 : 
			dialogue_box.read_text("Oh! I recognise some of those ppl!!!")
			header.text = "I'm BACK"
		1 : 
			dialogue_box.read_text("I'VE NEVER GOTTEN POPULAR!!!")
			header.text = "#1 VampireBL Author"
		2 : 
			dialogue_box.read_text("Oh! I recognise some of those ppl!!!")
			header.text = "I'm BACK"
		_ : 
			dialogue_box.read_text("Look at all those comments!")
			header.text = "WoWeee :0"

func quip(completion : float):
	
	#TODO: have a random chance to encourage/ egg on the player 
	if(randf() > 0.3):
		if(completion > 0.90):
			dialogue_box.read_text("Almost there! Just a bit more!!")
		if(completion > 0.75):
			dialogue_box.read_text("This is a great post so far, I love it!!")
		if(completion > 0.60):
			dialogue_box.read_text("I love this line, gotta be one of my favorites")
		if(completion > 0.50):
			dialogue_box.read_text("Typing is soooo much harder than it needs to be, but you're great at it1!!")
		if(completion > 0.25):
			dialogue_box.read_text("That's a really good start! Keep it going")
		else:
			dialogue_box.read_text("That's a good one")
