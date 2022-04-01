extends KinematicBody2D
class_name CharacterController

signal member_name_updated(new_name)
signal member_added(member_node)
signal active_members_updated
signal member_conviction_updated(member_name)
signal lead_member_changed(member_name)

export (Dictionary) var party_roster
export (Dictionary) var known_convictions

var direction = Vector2()
export (int) var max_speed = 400
var speed
var motion = Vector2()

var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false

export var max_party_size := 6


export (String) var active_member_name
export (Resource) var active_member_node

export(bool) var can_control
export (bool) var in_battle

onready var party_members = $PartyMembers


# Called when the node enters the scene tree for the first time.
func _ready():
	#this is to pass the conviction buffs or debuffs. need to possibly figure out better way
	EventBus.connect("cutscene_ended", self, "_on_dialog_ended")
	set_process(true)
	pass # Replace with function body.

func _process(delta):
	if in_battle:
		battle_movement()
	else:
		overworld_movement()

func battle_movement():
	pass
	
func overworld_movement():
	if can_control:
		direction = Vector2.ZERO
		speed = 0
		
		if Input.is_action_just_pressed("move_up"):
			direction.y = -1
		elif Input.is_action_just_pressed("move_down"):
			direction.y = 1

		if Input.is_action_just_pressed("move_left"):
			direction.x = -1
		elif Input.is_action_just_pressed("move_right"):
			direction.x = 1

		if not is_moving and direction != Vector2():
			target_direction = direction.normalized()
			if get_parent().tile_map.is_cell_vacant(position, direction):
				target_pos = get_parent().tile_map.update_child_pos(position, direction)
				is_moving = true
		elif is_moving:
			speed = max_speed
			# We have to convert the player's motion to the isometric system.
			# The target_direction is normalized a few lines above so the player moves at the same speed in all directions.
			motion = Global.utilities.cartesian_to_isometric(speed * target_direction)
			var pos = position
			var distance_to_target = pos.distance_to(target_pos)
			var move_distance = motion.length()

			# In the previous example, the player could land on floating positions
			# We force him to stop exactly on the target by setting the position instead of using the move method
			# As the grid handles the "collisions", we can use the two functions interchangeably:
			# move(motion) <=> set_pos(get_pos() + motion)
			if move_distance > distance_to_target:
				set_position(target_pos)
				is_moving = false
			else:
				position = pos + motion
	
func change_name(member, value: String):
	var old = member.name
	var new = value
	party_roster[new] = party_roster[old]
	party_roster[new].member.name = new
	party_roster[new].node.name = new
	party_roster[new].node.display_name = new
	party_roster.erase(old)
	emit_signal("member_name_updated", new)

func add_member(member, set_active:=false):
	var member_node = party_members.add_member(member)
	party_roster[member.name] = {"member": member, "party_active": set_active, "node": member_node}
	if set_active:
		set_active_member(member.name)
	emit_signal("member_added")
	
func set_party_active(member_name: String, value:= false):
	party_roster[member_name].party_active = value
	emit_signal("active_members_updated")

func toggle_party_active(member_name: String):
	party_roster[member_name].party_active = !party_roster[member_name].party_active
	emit_signal("active_members_updated")

func equip_conviction(member_name: String, conv: Conviction):
	party_roster[member_name].member.equipped_convictions[conv.name] = conv
	update_known_convictions()	
	emit_signal("member_conviction_updated", member_name)
	
func set_active_member(member_name: String):
	if party_roster.has(member_name):
		active_member_name = member_name
		active_member_node = party_roster[member_name].node
		emit_signal("lead_member_changed", member_name)

func update_known_convictions():
	for member in party_roster:
		for conviction in party_roster[member].node.convictions:
			if !known_convictions.has(conviction):
				known_convictions[conviction] = {"name": conviction, "owner": member}

func _on_dialog_ended(survival, strength, peace):
	#this is to pass the conviction buffs or debuffs. need to figure out better way
	if survival > 0:
		party_roster[active_member_name].node.add_conviction_experience("Survival", survival)
	if strength > 0:
		party_roster[active_member_name].node.add_conviction_experience("Strength", strength)
	if peace > 0:
		party_roster[active_member_name].node.add_conviction_experience("Peace", peace)
	pass


func _on_Player_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			$BattleMenu.visible = !$BattleMenu.visible
	pass # Replace with function body.
