extends Node2D

@export var guntip: Sprite2D
@export var rotation_speed_deg: float = 180.0 # Degrees per second
@export var reloadtime: float = 1
@onready var timesinceshot: float = reloadtime

func _physics_process(delta: float) -> void:
	var target_pos = get_global_mouse_position()
	var to_mouse = (target_pos - global_position).normalized()
	var current_facing = Vector2.RIGHT.rotated(rotation)  # Local right direction
	var max_angle = deg_to_rad(rotation_speed_deg * delta)

	var new_direction = rotate_toward_limited(current_facing, to_mouse, max_angle)
	rotation = new_direction.angle()
	
	if Input.is_action_just_pressed("shoot") and timesinceshot >= reloadtime:
		shoot()
		timesinceshot = 0
	timesinceshot += delta
	# print("Time since last gunshot: ", timesinceshot)
	

func rotate_toward_limited(from: Vector2, to: Vector2, max_angle: float) -> Vector2:
	if from == Vector2.ZERO or to == Vector2.ZERO:
		return from
	var angle_to_target = from.angle_to(to)
	var clamped_angle = clamp(angle_to_target, -max_angle, max_angle)
	return from.rotated(clamped_angle)

func shoot() -> void:
	var gunshot: AudioStreamPlayer2D = $Gunshot
	gunshot.pitch_scale = randf_range(0.9, 1.1)
	gunshot.play()
	var inst: Projectile = get_parent().projectile.instantiate()
	owner.owner.add_child(inst)
	inst.transform = guntip.transform
	inst.position = guntip.global_position
	inst.scale = Vector2(0.1, 0.1)
