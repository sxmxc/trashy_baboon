extends Node2D

onready var _music_player = $Music
onready var _sfx_player = $Sfx
onready var _efx_player = $Efx

export var audio_dict := {
	"Theme1": "res://audio/music/2015-10-07_-_Epic_Intro_Music_-_David_Fesliyan.mp3",
	"Theme2": "res://Audio/music/FutureAmbient_3.wav",
	"DialogTheme": "res://audio/music/2018-05-19_-_Video_Game_Adventure_-_David_Fesliyan.mp3",
	"BattleTheme1": "res://Audio/music/DarkDnB_2.wav"
	}
	
export var sfx_dict := {
	"ThunderClap1" : "res://Audio/sfx/ThunderClap.mp3",
	"Chime": "res://audio/sfx/chime.wav"
}	

export var efx_dict := {
	"ThunderStorm" : "res://audio/efx/rain_thunder_loop.wav"
}


# Called when the node enters the scene tree for the first time.
func _ready():
	print("AM: AudioManager ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func play_music(track : String):
	if audio_dict.has(track):
		print("AM: Playing %s" % track)
		_music_player.play(audio_dict[track])
	else:
		print("AM: Track %s not found" % track)

func stop_music():
	print("AM: Stopping Music")
	_music_player.stop()

func play_sfx(track : String):
	if sfx_dict.has(track):
		print("AM: Playing SFX %s" % track)
		_sfx_player.play(sfx_dict[track])
	else:
		print("AM: SFX track %s not found" % track)

func play_efx(track : String):
	if efx_dict.has(track):
		print("AM: Playing EFX %s" % track)
		_efx_player.play(efx_dict[track])
	else:
		print("AM: EFX track %s not found" % track)
		
func stop_efx():
	print("AM: Stopping EFX")
	_efx_player.stop()
