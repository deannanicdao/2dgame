extends CharacterBody2D

var health = 10

@onready var player = get_node("/root/Game/Player")

func _ready():
	# make sure the node is accessible (right click access as unique..)
	%Slime.play_walk()


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	
	move_and_slide()
	
func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		# add smoke as SIBLING, rather than child of MOB
		# this way it isn't affected by queue_free() above
		# useful if you need an effect after an entity is removed
		get_parent().add_child(smoke)
		smoke.global_position = global_position
