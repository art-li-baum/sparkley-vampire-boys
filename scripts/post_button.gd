extends Button

func _ready() -> void:
	GameManager.completedPost.connect(awake)
	

func awake():
	disabled = false
