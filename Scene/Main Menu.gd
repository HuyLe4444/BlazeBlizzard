extends Control

func _ready():
	pass

func _process(delta):
	pass
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
	
	
func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scene/settings_menu.tscn")
	
func _on_quit_pressed():
	get_tree().quit()
