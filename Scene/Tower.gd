extends Area2D

var mouse_in = null
@onready var animated_sprite_2d = $AnimatedSprite2D

func _position():
	return self.position

func health_Bar_Action():
	$HealthBar.value = Global.health
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://Scene/game_over_menu.tscn")

func _process(delta):
	health_Bar_Action()
	Global.x = self.position.x
	Global.y = self.position.y
