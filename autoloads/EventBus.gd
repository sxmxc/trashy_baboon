extends Node


#warning-ignore:unused_signal
signal cursor_moved(new_cell)
#warning-ignore:unused_signal
signal cell_selected(cell)
#warning-ignore:unused_signal
signal active_unit_changed(unit)
#warning-ignore:unused_signal
signal cutscene_begin(state)
#warning-ignore:unused_signal
signal cutscene_ended(survival, strength, peace)
#warning-ignore:unused_signal
signal dialog_starting
#warning-ignore:unused_signal
signal dialog_ended(survival, strength, peace)
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
signal game_start(msg)
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
#warning-ignore:unused_signal
signal conviction_learned(conviction_name)
#warning-ignore:unused_signal
signal conviction_updated
#warning-ignore:unused_signal
signal conviction_equipped
#warning-ignore:unused_signal
signal request_hide_cursor(value)
#warning-ignore:unused_signal
signal town_unlocked
#warning-ignore:unused_signal
signal battle_scene_ready(grid)
#warning-ignore:unused_signal
signal hidden_town_unlocked(town_name)
#warning-ignore:unused_signal
signal battle_message(message)
#warning-ignore:unused_signal
signal action_points_updated(value)
#warning-ignore:unused_signal
signal party_tab_member_selected(member)
