extends Node2D

@export var reggie : Node2D
@export var max_velocity = 90.0
@export var max_distance = 165
@onready var fast_move_mode: bool = false
@export var max_fast_speed_velocity: float = 180.0
	
func calculate_new_pos(start_vector : Vector2, end_vector :Vector2, delta: float) -> Vector2:
	var truevelocity: float
	if fast_move_mode:
		truevelocity = max_fast_speed_velocity
	else: truevelocity = max_velocity
	
	var direction = end_vector - start_vector
	var distance = direction.length()
	
	if distance >= max_distance:
		print("exceeded max distance")
		fast_move_mode = true
	if (distance < 10) and fast_move_mode:
		fast_move_mode = false
		print("Caught up with end vector")
		
	if distance <= truevelocity * delta:
		return end_vector
	else:
		# print("I think something happened here")
		return start_vector + direction.normalized() * truevelocity * delta
	
func _physics_process(delta):
	var new_pos = calculate_new_pos(global_position, reggie.global_position, delta)
	#print("Current Pos:", global_position)
	#print("Target Pos:", reggie.global_position)
	#print("Calculated Pos:", new_pos)
	#print("Distance:", position.distance_to(reggie.global_position))
	position = new_pos
