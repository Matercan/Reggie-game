extends Area2D

class_name Projectile

@export var speed: float = 200
@onready var reggie = get_tree().get_nodes_in_group("player")[0]
@export var length: float = 10
@onready var time:float = 0
@onready var direction: Vector2 = get_global_mouse_position() - find_gun_pos()

func _physics_process(delta: float) -> void:
	move(delta)
	time += delta
	if (time >= length): free()
	
func find_gun_pos() -> Vector2:
	var reggie_pos: Vector2 = reggie.global_position
	var end_vector = get_global_mouse_position()
	var direction = end_vector - reggie_pos
	return reggie_pos + direction.normalized()
	
func move(delta: float) -> void:
	print("TIME: ", time)
	direction = direction.normalized()
	print("Gun Direction: ", find_gun_pos())
	position += direction * speed * delta
	
