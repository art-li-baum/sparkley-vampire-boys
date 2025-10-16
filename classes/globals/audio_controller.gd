#load as AudioController throught Globals
extends Node

var key_press_sfx : AudioStreamRandomizer = preload("uid://4yr45wdhs83t")
var ghost_noise : AudioStreamRandomizer = preload("uid://5fvt8xu0t7ms")

var sfx_player : AudioStreamPlayer

func _ready() -> void:
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)

func play_key_press():
	sfx_player.stream = key_press_sfx
	sfx_player.play()

func play_ghost_noise(tone : float = 1.2):
	sfx_player.pitch_scale = tone
	sfx_player.stream = ghost_noise
	sfx_player.play()
