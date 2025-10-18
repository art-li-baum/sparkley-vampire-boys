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
	print(completion)
	#TODO: have a random chance to encourage/ egg on the player 
	if(randf() > 0.3):
		if(completion > 0.90):
			dialogue_box.read_text("almost there! just a bit more!! ^_^")
		elif(completion > 0.75):
			dialogue_box.read_text("this is a great post so far, i love it!!")
		elif(completion > 0.68):
			dialogue_box.read_text("oh i'm so excited to post this one!!")
		elif(completion > 0.60):
			dialogue_box.read_text("i love this line!! one of my favorites <3")
		elif(completion > 0.53):
			dialogue_box.read_text("squeeeeal! you're doinng great!") 
		elif(completion > 0.48):
			dialogue_box.read_text("typing is soooo much harder than it needs to be, but you're great at it1!!")
		elif(completion > 0.42):
			dialogue_box.read_text("ugh i love damien! he's so dreamy!!")
		elif(completion > 0.34):
			dialogue_box.read_text("aaa i love alaric!! he's so handsome...")
		elif(completion > 0.26): 
			dialogue_box.read_text("omg we're making progress on this chapter so fast!")
		elif(completion > 0.16):
			dialogue_box.read_text("that's a really good start! keep it going! owo")
		else:
			dialogue_box.read_text("yaaay! you finished typing a line!")
