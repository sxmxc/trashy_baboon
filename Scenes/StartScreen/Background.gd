extends ParallaxBackground
onready var animation = $AnimationPlayer
onready var timer = $Timer

var rng = RandomNumberGenerator.new()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.play_sfx("ThunderStorm")
	rng.set_seed(OS.get_time().second)
	rng.randomize()
	timer.start(rng.randi_range(10,20))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	Global.play_sfx("ThunderClap1")
	animation.play("lightning_strike")
	yield(Global._sfx_player,"finished")
	Global.play_sfx("ThunderStorm")
	timer.start(rng.randi_range(10,20))
	pass # Replace with function body.
