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
			dialogue_box.read_text("oh! i recognise some of those ppl!!!")
			header.text = "i'm back!"
		1 : 
			dialogue_box.read_text("i've never gotten popular before XD!!!")
			header.text = "#1 vampire bl author <3"
		2 : 
			dialogue_box.read_text("let's see if our fans like the added drama!!")
			header.text = "plot twist!"
		3 : 
			dialogue_box.read_text("omg... what are these people saying about me?!??")
			header.text = "O-o"
		4 : 
			dialogue_box.read_text("omg... what are these people saying about me?!??")
			header.text = "O-o"
		5 : 
			dialogue_box.read_text("i'm so glad to see a couple of my fans are still around uwu...")
			header.text = "my loyal followers!"
		6 : 
			dialogue_box.read_text("DAMIEN x ALARIC FOREVER!!!! ")
			header.text = "the last kiss!!!"
		7 : 
			dialogue_box.read_text("just a ghoul writing vampire fanfic ;3")
			header.text = "About Me"
			
func quip(completion : float):
	
	#TODO: have a random chance to encourage/ egg on the player 
	if(randf() > 0.3):
		if(completion > 0.90):
			dialogue_box.read_text("almost there! just a bit more!! ^_^")
		if(completion > 0.75):
			dialogue_box.read_text("this is a great post so far, i love it!!")
		if(completion > 0.60):
			dialogue_box.read_text("i love this line, gotta be one of my favorites <3")
		if(completion > 0.50):
			dialogue_box.read_text("typing is soooo much harder than it needs to be, but you're great at it1!!")
		if(completion > 0.25):
			dialogue_box.read_text("that's a really good start! keep it going! owo")
		else:
			dialogue_box.read_text("that's a good one!")
