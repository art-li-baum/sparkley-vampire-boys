class_name ConversationPanel extends CanvasItem

@export var portrait : TextureRect
@export var portaint_anim : AnimationPlayer
@export var conversation : RichTextLabel

var current_convo : Conversation

func _ready() -> void:
	GameManager.openConvo.connect(open_convo)
	GameManager.newBlogPost.connect(close_convo)
	visible = false

func open_convo(convo : Conversation):
	#TODO: some opening animations mayhaps?
	visible = true
	current_convo = convo
	conversation.open_line(convo.lines[0])

func close_convo(_bd):
	#TODO: close animation?
	visible = false

func play_next_line():
	var line = current_convo.next_line()
	if(line == null): return

	portaint_anim.play(line.anim_state)
	conversation.open_line(line)

	#TODO: add animation support
