extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func save_settings(settings):
	var config = ConfigFile.new()
	if settings.has("resolution"):
		config.set_value("Display", "resolution", settings.resolution)
	if settings.has("fullscreen"):
		config.set_value("Display", "fullscreen", settings.fullscreen)
	if settings.has("master_volume"):
		config.set_value("Audio", "master_volume", settings.master_volume)
	if settings.has("sfx_volume"):
		config.set_value("Audio", "sfx_volume", settings.sfx_volume)
	if settings.has("music_volume"):
		config.set_value("Audio", "music_volume", settings.music_volume)
	config.save("user://settings.ini")
	print_debug("Settings Saved")
	pass

func load_settings():
	var settings = {}
	var config = ConfigFile.new()
	var err = config.load("user://settings.ini")
	if err != OK:
		return null
	settings.fullscreen = config.get_value("Display", "fullscreen")
	settings.master_volume = config.get_value("Audio", "master_volume")
	settings.sfx_volume = config.get_value("Audio", "sfx_volume")
	settings.music_volume = config.get_value("Audio", "music_volume")
	print_debug("Settings Loaded")
	return settings
	pass
	
func save_game():
	pass

func load_game():
	pass
	
func get_saved_games():
	pass
