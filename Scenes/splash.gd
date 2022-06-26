extends Control

onready var background_anim = $Background/AnimationPlayer
onready var logo_anim = $Logo/AnimationPlayer

signal fade_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fade_out():
	var timer = Timer.new()
	add_child(timer)
	timer.start(3)
	yield(timer,"timeout")
	timer.queue_free()
	background_anim.play("fade_out")
	yield(background_anim, "animation_finished")
	logo_anim.play("fade_out")
	yield(logo_anim, "animation_finished")
	emit_signal("fade_finished")
	self.visible = false
