extends Node2D

@export var reggie : Node2D
@export var max_velocity = 90.0
	
func calculate_new_pos(start_vector : Vector2, end_vector :Vector2, delta: float) -> Vector2:
	var direction = end_vector - start_vector
	var distance = direction.length()
	
	if distance <= max_velocity * delta:
		return end_vector
	else:
		print("I think something happened here")
		return start_vector + direction.normalized() * max_velocity * delta
	
func _physics_process(delta):
	var new_pos = calculate_new_pos(global_position, reggie.global_position, delta)
	print("Current Pos:", global_position)
	print("Target Pos:", reggie.global_position)
	print("Calculated Pos:", new_pos)
	print("Distance:", position.distance_to(reggie.global_position))
	position = new_pos
