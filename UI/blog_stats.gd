class_name BlogStats extends Control

@export var follower_count : RichTextLabel
@export var likes_count : RichTextLabel

@export var animator : AnimationPlayer

const rolling_effect : String = "[roll]10000000[/roll]"

var followers = 10
var likes = 30
var current_score : int = 0

var current_loop : int = 0

func _ready() -> void:
	GameManager.openEval.connect(set_rolling)
	GameManager.reset.connect(_reset)
	
	follower_count.text = str(followers)
	likes_count.text = str(likes)

func _reset():
	followers = 10
	likes = 30
	
	follower_count.text = str(followers)
	likes_count.text = str(likes)
	
func set_rolling(loop, score):
	current_score = score
	
	current_loop = loop
	
	follower_count.text = rolling_effect
	likes_count.text = rolling_effect

func reveal():
	
	#Perfect bonus
	if(current_score == 100):
		followers += randi() % 50 + 20
		likes += randi() % 300 + 50
	else:
		followers += randi() % 10 + 3
		likes += randi() % 100 + 10
	
	#for scripted story things
	match(current_loop):
		4: #crashout 
			followers = 10
			likes += 2
		

	
	animator.play("ding")
	AudioController.play_ding_noise()
	
	follower_count.text = str(followers)
	likes_count.text = str(likes)
