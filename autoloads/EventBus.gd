extends Node

#warning-ignore:unused_signal
signal game_world_ready
#warning-ignore:unused_signal
signal cutscene_begin(state)
#warning-ignore:unused_signal
signal cutscene_ended(survival, strength, peace)
#warning-ignore:unused_signal
signal dialog_starting
#warning-ignore:unused_signal
signal dialog_ended(survival, strength, peace)
#warning-ignore:unused_signal
signal party_updated(msg)
#warning-ignore:unused_signal
signal member_joined(member)
#warning-ignore:unused_signal
signal lead_member_changed(member_node)
#warning-ignore:unused_signal
signal member_name_updated(new_name)
#warning-ignore:unused_signal
signal member_added(member_node)
#warning-ignore:unused_signal
signal active_members_updated
#warning-ignore:unused_signal
signal member_conviction_updated(member_name)
#warning-ignore:unused_signal
signal interaction_pressed(member_name)
#warning-ignore:unused_signal
signal quit_requested
#warning-ignore:unused_signal
signal menu_opened
#warning-ignore:unused_signal
signal menu_closed
#warning-ignore:unused_signal
signal system_menu_opened
#warning-ignore:unused_signal
signal system_menu_closed
#warning-ignore:unused_signal
signal player_grid_position_updated(new_position, offset)
#warning-ignore:unused_signal
signal mouse_grid_position_updated(grid_position, world_position, offset, tile_id)
#warning-ignore:unused_signal
signal transition_ready
#warning-ignore:unused_signal
signal transition_end
#warning-ignore:unused_signal
signal inventory_updated(msg)
#warning-ignore:unused_signal
signal game_start(msg)
#warning-ignore:unused_signal
signal map_changed(map)
#warning-ignore:unused_signal
signal map_ready(player)
#warning-ignore:unused_signal
signal active_map_set(map)
#warning-ignore:unused_signal
signal battle_requested(state)
#warning-ignore:unused_signal
signal battle_begin(state)
#warning-ignore:unused_signal
signal battle_queue_updated(state)
#warning-ignore:unused_signal
signal battle_end(state)
#warning-ignore:unused_signal
signal turn_begin(active_member)
#warning-ignore:unused_signal
signal turn_end(next_active_member)
#warning-ignore:unused_signal
signal conviction_xp_gained(conviction_name, amount)


