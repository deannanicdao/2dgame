extends Area2D

var travelled_distance = 0

func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1200
	
	# no move and slide for areas, instead use position
	# RIGHT is the "y-vertical axis" i.e., (0,1)
	# vector 2 function returns a NEW VECTOR, rotated by the desired angle
	# "rotation" property of the bullet provides that angle
	# aim: rotate the bullet and return the current direction the bullet is pointing
	var direction = Vector2.RIGHT.rotated(rotation)
	
	# multiply direction by a speed, and it will move that entity (bullet)
	position += direction * SPEED * delta
	
	# delta makes it time dependent, rather than frame dependent
	# didn't use this when setting the velocity in the Player scene because the "move and slide" automatically applies delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		# destroy the bullet
		queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
