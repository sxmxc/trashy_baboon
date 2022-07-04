tool
extends EditorPlugin

## Path to the version script file (bruh).
const VERSION_SCRIPT_PATH = "res://version.gd"
const PROJECT_VERSION_SETTING = "application/config/version"
const PROJECT_BUILD_SETTING = "application/config/build"

func _fetch_build(features: PoolStringArray, is_debug: bool, path: String, flags: int) -> String:
	var output := []
	OS.execute("git", PoolStringArray(["rev-parse", "--short", "HEAD"]), true, output)
	if output.empty() or output[0].empty():
		push_error("Failed to fetch version. Make sure you have git installed and project is inside valid git directory.")
	else:
		print(output[0].trim_suffix("\n"))
		return output[0].trim_suffix("\n")
	return ""
	
func _fetch_version(features: PoolStringArray, is_debug: bool, path: String, flags: int) -> String:
	
	var version = ProjectSettings.get_setting(PROJECT_VERSION_SETTING)
	if version.empty():
		push_error("Failed to fetch version. No valid version key found in export profiles.")
	else:
		return version
	return ""

### Unimportant stuff here.

var exporter: AEVExporter

func _enter_tree() -> void:
	exporter = AEVExporter.new()
	exporter.plugin = self
	add_export_plugin(exporter)
	
	if not File.new().file_exists(VERSION_SCRIPT_PATH):
		exporter.store_version(_fetch_version(PoolStringArray(), true, "", 0),_fetch_build(PoolStringArray(), true, "", 0))

func _exit_tree() -> void:
	remove_export_plugin(exporter)

class AEVExporter extends EditorExportPlugin:
	var plugin
	
	func _export_begin(features: PoolStringArray, is_debug: bool, path: String, flags: int):
		var version: String = plugin._fetch_version(features, is_debug, path, flags)
		var build: String = plugin._fetch_build(features, is_debug, path, flags)
		if version.empty():
			push_error("Version string is empty. Make sure your _fetch_version() is configured properly.")
		if build.empty():
			push_error("Version string is empty. Make sure your _fetch_build() is configured properly.")	
		
		store_version(version,build)

	func store_version(version: String, build: String):
		ProjectSettings.set_setting(PROJECT_BUILD_SETTING, build)
		var script = GDScript.new()
		script.source_code = str("extends Reference\nconst VERSION = \"%s\"\nconst BUILD = \"%s\"\n" % [version,build])
		if ResourceSaver.save(VERSION_SCRIPT_PATH, script) != OK:
			push_error("Failed to save version file. Make sure the path is valid.")
