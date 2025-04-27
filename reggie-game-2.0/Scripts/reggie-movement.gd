extends CharacterBody2D

@export var move_speed : float = 100

func _physics_process(_delta):
	#get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	#Update velocity
	if input_direction.x != 0 and input_direction.y != 0:
		input_direction *= 1 / sqrt(2)
	
	velocity = input_direction * move_speed
	
	#Move reggie on screen
	move_and_slide()
