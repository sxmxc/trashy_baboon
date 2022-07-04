extends Panel

onready var fullscreen = $VBoxContainer/CheckButton
onready var master_volume = $VBoxContainer/MasterSlider
onready var music_volume = $VBoxContainer/MusicSlider
onready var sfx_volume = $VBoxContainer/SFXSlider
onready var save_settings_button = $SettingsSaveButton

var settings_saved = true

var settings_dict = {
	"resolution" : 1,
	"fullscreen" : false,
	"master_volume" : 1, 
	"music_volume" : 1, 
	"sfx_volume" : 1
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("UI:SETTINGS Settings menu ready")
	load_settings()
	fullscreen.set_pressed_no_signal(settings_dict.fullscreen)
	master_volume.value = settings_dict.master_volume
	music_volume.value = settings_dict.music_volume
	sfx_volume.value = settings_dict.sfx_volume
	set_process(true)
	pass # Replace with function body.

func _process(_delta):
	save_settings_button.disabled = settings_saved
	

func save_settings():
	print("UI:SETTINGS Saving settings")
	SaveManager.save_settings(settings_dict)
	settings_saved = true
	
func load_settings():
	print("UI:SETTINGS Loading settings")
	var settings = SaveManager.load_settings()
	if settings.size() > 0:
		settings_dict = settings
		apply_settings()

func apply_settings():
	print("UI:SETTINGS Applying settings")
	OS.window_fullscreen = settings_dict.fullscreen
	pass	


func _on_CheckButton_toggled(button_pressed):
	settings_saved = false
	settings_dict.fullscreen = button_pressed
	OS.window_fullscreen = button_pressed
	pass # Replace with function body.


func _on_SettingsSaveButton_pressed():
	save_settings()
	pass # Replace with function body.
