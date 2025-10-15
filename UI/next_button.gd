class_name NextButton extends Button

@export var stats : BlogStats

var is_revealed = false

func _ready() -> void:
	visible = false
	GameManager.openConvo.connect(on_convo)
	GameManager.openEval.connect(on_eval)

func on_eval(_loop,_score):
	visible = true
	is_revealed = false

func on_convo(_cn):
	visible = false


func _on_button_next_pressed():
	if(is_revealed):
		GameManager.completeLoop.emit()
	else:
		stats.reveal()
		is_revealed = true
		
