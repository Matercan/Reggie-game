extends Area2D

class_name Fireball

@onready var spawner: StaticBody2D
@onready var reggie: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
@onready var dir: Vector2 = get_direction()
@onready var speed: float = 100
@export var timer: float = 0
@export var time: float = 20

func _ready() -> void:
	print("Reggie Name: ", reggie.name)
	print("Wizard: ", spawner)
	add_to_group("Fireball")
	add_to_group("Hurtbox")

func get_direction() -> Vector2:
	var target: Vector2
	target = (reggie.global_position - global_position).normalized()
	return target
	
func _process(delta: float) -> void:
	move(delta)
	
	if timer > time:
		queue_free()
	timer += delta
	
func move(delta: float) -> void:
	print("Direction of Fireball: ", dir)
	print("Fireball target direction: ", reggie.global_position)
	print("Fireball position: ", global_position)
	position += dir * speed * delta
	
