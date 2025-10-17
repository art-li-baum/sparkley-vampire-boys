#load as AudioController throught Globals
extends Node

var key_press_sfx : AudioStreamRandomizer = preload("uid://4yr45wdhs83t")
var ghost_noise : AudioStreamRandomizer = preload("uid://5fvt8xu0t7ms")

var main_music : AudioStream = preload("uid://b0c10b0uylflm")

var sfx_players : Array[AudioStreamPlayer]

var ghost_player : AudioStreamPlayer

func _ready() -> void:
	sfx_players = []
	ghost_player = AudioStreamPlayer.new()
	add_child(ghost_player)
	ghost_player.stream = ghost_noise

func play_key_press():
	var sfx_player = get_free_player()
	sfx_player.stream = key_press_sfx
	sfx_player.play()

func play_ghost_noise(tone : float = 1.2):
	ghost_player.pitch_scale = tone
	ghost_player.play()

func play_music(track : AudioStream = main_music):
	var p = get_free_player()
	p.stream = track
	p.play()

func get_free_player()-> AudioStreamPlayer:
	
	for p in sfx_players:
		if(!p.playing):
			return p
	
	var player = AudioStreamPlayer.new()
	add_child(player)
	
	sfx_players.push_back(player)
	
	return player
