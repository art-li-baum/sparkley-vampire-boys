extends Button

func _ready() -> void:
	GameManager.finishedPost.connect(awake)
	

func awake():
	disabled = false
