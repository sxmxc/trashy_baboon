extends ParallaxBackground
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var lightning = $LightningGroup

var rng = RandomNumberGenerator.new()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play_efx("ThunderStorm")
	rng.set_seed(OS.get_time().second)
	rng.randomize()
	timer.start(rng.randi_range(10,20))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($ParallaxLayer, "modulate", Color(.5,.5,1, 1),.5).set_trans(Tween.TRANS_BOUNCE).set_trans(Tween.EASE_IN_OUT)
	tween.tween_method(lightning,"set_visible", false, true,.5)
	tween.chain().tween_method(lightning,"set_visible", true, false,.5)
	tween.chain().tween_property($ParallaxLayer, "modulate", Color(.10,.10, 1, 1),.1).set_trans(Tween.TRANS_BACK)
	tween.tween_callback(rng, "randi_range", [10,20])
	tween.play()
	AudioManager.play_sfx("ThunderClap1")
	pass # Replace with function body.
