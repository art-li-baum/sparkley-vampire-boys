extends ProgressBar

var allotted_time 

var current_time = -1

func _ready() -> void:
	GameManager.newBlogPost.connect(start_timer)


func start_timer(post : BlogPost):
	allotted_time = post.time_to_write
	if (allotted_time <= 0):
		post.eval_time()
		allotted_time = post.time_to_write
	current_time = 0
	value = 100

func _process(delta: float) -> void:
	if(GameManager.current_state != GameManager.STATE.POST): return
	if(current_time < 0): return
	
	current_time += delta
	
	value = 100 - current_time/allotted_time * 100
	
	if(current_time > allotted_time):
		current_time = -1
		GameManager.postFailed.emit()
