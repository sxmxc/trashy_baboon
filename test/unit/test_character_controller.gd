extends "res://addons/gut/test.gd"
func before_each():
	gut.p("ran setup", 2)

func after_each():
	gut.p("ran teardown", 2)

func before_all():
	gut.p("ran run setup", 2)

func after_all():
	gut.p("ran run teardown", 2)

func test_member_adding():
	watch_signals(EventBus)
	var char_controller = load("res://CharacterSystem/Scenes/Player/Player.tscn").instance()
	var member_data = load("res://CharacterSystem/Resources/Characters/alpha.tres")
	add_child_autoqfree(char_controller)
	char_controller.add_member(member_data, true)
	assert_signal_emitted(EventBus, 'member_added')
	assert_eq(char_controller.active_member_name, member_data.name, "Active member name shoud equal member data name")
	
