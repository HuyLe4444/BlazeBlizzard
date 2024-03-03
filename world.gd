extends Node

var enemy = preload("res://Scene/Slime.tscn")
var firewood = preload("res://Scene/firewood.tscn")
var mineral = preload("res://Scene/mineral.tscn")
var turret = preload("res://Scene/turret.tscn")
var snowman = preload("res://Scene/snowman.tscn")
var frostguard = preload("res://Scene/frost_guard.tscn")
var bought = false
var index = 0
var price = 0

var turret_positions = [
	Vector2(640,560),
	Vector2(449.788696, 421.803398),  
	Vector2(522.44295, 198.196602),
	Vector2(757.55705, 198.196602),
	Vector2(830.211304, 421.803398)
]

func spawn_turret():
	if index < 5:
		var turrets = turret.instantiate()
		add_child(turrets)
		turrets.position = turret_positions[index]
		index += 1

func _process(delta):
	$Label.text = "Resources: " + str(Global.resources)
	
	if Input.is_action_just_pressed("click") and bought == true:
		spawn_turret()
		bought = false
		
	if Global.level == 1:
		Global.health += 10
		Global.slime_spawn_rate = 0.002
	elif Global.level == 2:
		Global.slime_spawn_rate = -0.004
		#Global.cursor_damage += 15
		Global.mob_speed += 10
	elif Global.level == 3:
		Global.health += 10
		Global.slime_spawn_rate = -0.002
		Global.snowman_spawn_rate = 0.002
	elif Global.level == 4:
		Global.health += 20
		#Global.cursor_damage += 30
		Global.mob_speed += 10
	
	
	if randf() < 0.01 + Global.slime_spawn_rate:
		spawn()
	
	if Global.level >= 2:
		if randf() < 0.004 + Global.snowman_spawn_rate:
			spawn_Snowman()
	
	if Global.level == 4:
		if randf() < 0.001:
			spawn_FrostGuard()
	
	if randf() < 0.008:
		spawnFirewood()
		
	if randf() < 0.002:
		spawnMineral()
	
func spawnMineral():
	var new_spawn = mineral.instantiate()
	add_child(new_spawn)

	var viewport = get_viewport()
	var viewport_bounds = viewport.get_visible_rect()
	
	new_spawn.position.x = randf_range(0, viewport_bounds.size.x)
	new_spawn.position.y = randf_range(0, viewport_bounds.size.y)

func spawnFirewood():
	var new_spawn = firewood.instantiate()
	add_child(new_spawn)

	var viewport = get_viewport()
	var viewport_bounds = viewport.get_visible_rect()
	
	new_spawn.position.x = randf_range(0, viewport_bounds.size.x)
	new_spawn.position.y = randf_range(0, viewport_bounds.size.y)
   
func spawn():
	var new_spawn = enemy.instantiate() 
	add_child(new_spawn)
   
	var screen_size = get_viewport().get_visible_rect().size
	var margin = 50

	var locations = [
	  Vector2(margin, margin),
	  Vector2(screen_size.x - margin, margin), 
	  Vector2(margin, screen_size.y - margin),
	  Vector2(screen_size.x - margin, screen_size.y - margin)
   ]
   
	new_spawn.position = locations[randi() % locations.size()]
	
func spawn_Snowman():
	var new_spawn = snowman.instantiate() 
	add_child(new_spawn)
   
	var screen_size = get_viewport().get_visible_rect().size
	var margin = 50

	var locations = [
	  Vector2(margin, margin),
	  Vector2(screen_size.x - margin, margin), 
	  Vector2(margin, screen_size.y - margin),
	  Vector2(screen_size.x - margin, screen_size.y - margin)
   ]
   
	new_spawn.position = locations[randi() % locations.size()]
	
func spawn_FrostGuard():
	var new_spawn = frostguard.instantiate() 
	add_child(new_spawn)
   
	var screen_size = get_viewport().get_visible_rect().size
	var margin = 50

	var locations = [
	  Vector2(margin, margin),
	  Vector2(screen_size.x - margin, margin), 
	  Vector2(margin, screen_size.y - margin),
	  Vector2(screen_size.x - margin, screen_size.y - margin)
   ]
   
	new_spawn.position = locations[randi() % locations.size()]

func _on_button_pressed():
	if Global.count == 0:
		price = 15
	elif Global.count == 1:
		price = 30
	elif Global.count == 2:
		price = 45
	elif Global.count == 3:
		price = 60
	elif Global.count == 4:
		price = 75
	elif Global.count == 5:
		price = 80
	elif Global.count == 6:
		price = 100
	else:
		pass
		
	print(price)
		
	if Global.resources >= price and Global.count <= 6:
		if price == 80:
			Global.tower_damage += 10
			Global.tower_reloaded_time -= 0.1
		if price == 100:
			Global.tower_damage += 10
			Global.tower_reloaded_time -= 0.1
		Global.resources -= price
		Global.count += 1
		bought = true
