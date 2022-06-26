extends Node2D

onready var menu_player = $MenuCanvas/AnimationPlayer
onready var splash_screen = $SplashCanvas/SplashScreen


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_enter_animation()
	pass # Replace with function body.

func _enter_animation():
	#Global.play_audio("Theme1")
	splash_screen.fade_out()
	yield(splash_screen, "fade_finished")
	menu_player.play("title_down")
	yield(menu_player,"animation_finished")
	menu_player.play("main_menu_up")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewGameButton_pressed():
	menu_player.play("new_game_in")
	pass # Replace with function body.


func _on_ContinueButton_pressed():
	pass # Replace with function body.


func _on_SettingsButton_pressed():
	menu_player.play("settings_in")
	pass # Replace with function body.


func _on_ExitButton_pressed():
	pass # Replace with function body.


func _on_SettingsBackButton_pressed():
	menu_player.play_backwards("settings_in")
	pass # Replace with function body.


func _on_NewGameStartButton_pressed():
	Global.start_game()
	Global._sfx_player.stop()
	pass # Replace with function body.


func _on_NewGameBackButton_pressed():
	menu_player.play_backwards("new_game_in")
	pass # Replace with function body.


func _on_LineEdit_text_changed(new_text):
	Global.player_dict.player_name = new_text
	pass # Replace with function body.
