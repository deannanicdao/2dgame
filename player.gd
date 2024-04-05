extends CharacterBody2D
signal health_depleted

var health = 100.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	if velocity.length() > 0.0:
		# if you reparent a node, you'll have to adjust the pathname in get_node below 
		%HappyBoo.play_walk_animation()
	else:
		# pro: using % gives a performance benefit, will call once
		# con: only works within this scene
		%HappyBoo.play_idle_animation()

	const DAMAGE_RATE = 5.0 

	var overlapping_mobs = %HurtBox.get_overlapping_bodies()

	if overlapping_mobs.size() > 0:
		# without delta, health will go down in an instant
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		
		%ProgressBar.value = health
		# can also change values from code
		# e.g. %ProgressBar.max_value = 500 to set this value from here
		if health <= 0.0:
			# signal for game over screen
			# emit signal only, custom hook
			health_depleted.emit()
			
		
	
