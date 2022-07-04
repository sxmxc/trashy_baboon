extends MarginContainer


onready var log_list = $Panel/BattleLogContainer/LogScroll/LogList
onready var log_scroll = $Panel/BattleLogContainer/LogScroll


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("battle_message", self, "log_battle_message")
	clear_logs()
	pass # Replace with function body.


func clear_logs():
	for child in log_list.get_children():
		child.queue_free()

func log_battle_message(message: String):
	var log_message = Label.new()
	log_message.text = message
	log_list.add_child(log_message)
	yield(get_tree().create_timer(.1), "timeout")
	log_scroll.scroll_vertical = log_scroll.get_v_scrollbar().max_value
