extends Control

var seconds = 0
var minutes = 0
var Dseconds = 0
var Dminutes = 2
 
func _ready():
	Reset_Timer()
	pass

func _on_timer_timeout():
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
		
	seconds -= 1
	if seconds <= 0 and Global.level < 5:
		Dseconds = 0
		Dminutes = 2
		Global.level += 1
		Reset_Timer()
	elif Global.level >= 5:
		get_tree().change_scene_to_file("res://win_screen.tscn")
	$Label.text = "Level: " + str(Global.level + 1) + " - " + str(minutes) + ":" + str(seconds)
	
func Reset_Timer():
	seconds = Dseconds
	minutes = Dminutes
