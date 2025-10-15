class_name BlogStats extends Control

@export var follower_count : RichTextLabel
@export var likes_count : RichTextLabel

const rolling_effect : String = "[roll]10000000[/roll]"

var followers = 10
var likes = 30
var current_score : int = 0

func _ready() -> void:
	GameManager.openEval.connect(set_rolling)
	
func set_rolling(_loop, score):
	current_score = score
	
	follower_count.text = rolling_effect
	likes_count.text = rolling_effect

func reveal():
	if(current_score == 100):
		followers += randi() % 80 + 20
		likes += randi() % 300 + 50
	
	
	follower_count.text = str(followers)
	likes_count.text = str(likes)
