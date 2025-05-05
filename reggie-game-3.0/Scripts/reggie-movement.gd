extends CharacterBody2D

@export var move_speed : float

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if input_direction.x != 0 and input_direction.y != 0:
		input_direction *= 1/sqrt(2)

	velocity = input_direction * move_speed
	
	
	move_and_slide()
