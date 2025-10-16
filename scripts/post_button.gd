class_name PostButton extends Button

@export var stats : BlogStats

var current_function : Callable = submit

func _ready() -> void:
	GameManager.finishedPost.connect(awake)
	GameManager.submitPost.connect(did_fail)
	GameManager.newBlogPost.connect(_open_post)

func _open_post(_bp):
	text = "POST"
	disabled = true

func awake():
	disabled = false
	grab_focus()
	current_function = submit

func did_fail(failed : bool):
	if(failed):
		text = "NEXT"
		current_function = reveal

func submit():
	GameManager.submitPost.emit(true)
	text = "NEXT"
	current_function = reveal

func reveal():
	stats.reveal()
	current_function = complete

func complete():
	disabled = true
	GameManager.completeLoop.emit()

func _on_button_next_pressed():
	current_function.call()
		
