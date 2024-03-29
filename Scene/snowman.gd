extends CharacterBody2D

var health = 200
var mouse_in = null
var is_Hurt = false
#var visible_check_mouse = false
#var visible_check_firewood = false
var tower_pos = Vector2.ZERO

var SPEED = 60 + Global.mob_speed
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var sound_effect_2d = $AudioStreamPlayer2D

func health_Bar_Action():
	var healthBar = $HealthBar
	healthBar.value = health
	
	if Input.is_action_just_pressed("click") and mouse_in == true:
		sound_effect_2d.play()
		health -= (10 + Global.cursor_damage)

	if healthBar.value <= 0:
		queue_free()

func _physics_process(delta):
	#print(visible_check_mouse)
	#print(visible_check_firewood)
	#if Global.is_Lit == true or visible_check_mouse == true:
		#self.visible = true
	#else:
		#self.visible = false
		
	tower_pos.x = Global.x
	tower_pos.y = Global.y
	health_Bar_Action()
	position = position.move_toward(tower_pos, delta * SPEED)
	if position.distance_to(tower_pos) < 50:
		Global.health -= 20
		queue_free()

	health_Bar_Action()
	move_and_slide()

func snowman():
	pass

#func _on_cursor_enemy_appered():
	#visible_check_mouse = true
#
#func _on_cursor_enemy_dis_appered():
	#visible_check_mouse = false

func _on_area_2d_mouse_entered():
	mouse_in = true

func _on_area_2d_mouse_exited():
	mouse_in = false

#func _on_firewood_enemy_appered():
	#visible_check_firewood = true
#
#func _on_firewood_enemy_dis_appered(isLit):
	#visible_check_firewood = false
