#load as AudioController throught Globals
extends Node

var key_press_sfx : AudioStreamRandomizer = preload("uid://4yr45wdhs83t")
var ghost_noise : AudioStreamRandomizer = preload("uid://5fvt8xu0t7ms")
var pop_noise : AudioStream = preload("uid://cbdaawyq3g2p7")
var ding_noise : AudioStream = preload("uid://c2qft6eiuwuyo")

var main_music : AudioStream = preload("uid://b0c10b0uylflm")

var sfx_players : Array[AudioStreamPlayer]

var ghost_player : AudioStreamPlayer
var audio_player : AudioStreamPlayer

func _ready() -> void:
	sfx_players = []
	ghost_player = AudioStreamPlayer.new()
	add_child(ghost_player)
	ghost_player.stream = ghost_noise
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)

func play_key_press():
	var sfx_player = get_free_player()
	sfx_player.stream = key_press_sfx
	sfx_player.play()

func play_pop_noise():
	var sfx_player = get_free_player()
	sfx_player.stream = pop_noise
	sfx_player.play()

func play_ding_noise():
	var sfx_player = get_free_player()
	sfx_player.stream = ding_noise
	sfx_player.play()

func play_ghost_noise(tone : float = 1.2):
	ghost_player.pitch_scale = tone
	ghost_player.play()

func play_music(track : AudioStream = main_music):
	if(audio_player.playing): return
	audio_player.stream = track
	audio_player.play()

func get_free_player()-> AudioStreamPlayer:
	
	for p in sfx_players:
		if(!p.playing):
			return p
	
	var player = AudioStreamPlayer.new()
	add_child(player)
	
	sfx_players.push_back(player)
	
	return player
