extends CharacterBody2D

@export var move_speed : float = 100
@export var drag : float = 0.95
@export var acceleration : float = 0.1

func _physics_process(_delta):
	#get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	if input_direction.x != 0 and input_direction.y != 0:
		input_direction *= 1 / sqrt(2)
	
	#calculate velocity
	velocity += input_direction * move_speed * acceleration
	velocity *= drag
	
	if input_direction.x != 0 and input_direction.y != 0:
		if abs(velocity.x) > move_speed / sqrt(2):
			velocity.x = move_speed * sign(velocity.x)
		if abs(velocity.y) > move_speed / sqrt(2):
			velocity.y = move_speed * sign(velocity.y)
	else: 
		if (abs(velocity.x) > move_speed):
			velocity.x = move_speed * sign(velocity.x)
		if (abs(velocity.y) > move_speed):
			velocity.y = move_speed * sign(velocity.y)
	
	#Move reggie on screen
	move_and_slide()
