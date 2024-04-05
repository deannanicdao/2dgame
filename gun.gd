extends Area2D

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot():
	# preload() - loads prior to game launch
	# load() - loads on demand
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	
	# access the location of the "shooting point" in code 
	# by accessing its unique name
	# right click on shooting point
	# access unique name
	# use global_position in both cases because
	# "position" is relative to the parent node, so the pistol in this case
	# global position is the absolute position in the entire game world
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	
	# new instance of a bullet is added to gun
	%ShootingPoint.add_child(new_bullet)
	
	# add automatic shooting by adding a timer node
	# go into inspector, change wait time to 0.3s and tick "Autostart"
	# go to node, double click timeout() signal 
	# create a connection to Gun node, will create template of function below
	# bullets are offset, go to bullet node
	# then inspector
	# search for top level under visibility tab
	# bullet will now move independently from its parent node
	# add new line above (new_bullet.global_rotation = %ShootingPoint.global_rotation)
	

func _on_timer_timeout():
	shoot()
	
