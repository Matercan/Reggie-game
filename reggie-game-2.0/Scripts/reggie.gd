extends CharacterBody2D

class_name Player

@export var move_speed : float = 100
@export var drag : float = 0.95
@export var acceleration : float = 0.1
@export var projectile: PackedScene
@export var gun: Node2D
@export var Maxhealth: float = 100
@export var Health: float = 100

func _ready():
	add_to_group("Player")
	
func has_variable(node: Object, var_name: String) -> bool:
	return var_name in node.get_property_list().map(func(p): return p.name)


func _physics_process(_delta) -> void:
	move()


func move() -> void:
	#get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	if input_direction.x != 0 and input_direction.y != 0:
		input_direction *= 1 / sqrt(2)
	
	#calculate velocity
	if !velocity.length() > move_speed: 
		velocity += input_direction * move_speed * acceleration
	velocity *= drag
	
	
	#Move reggie on screen
	move_and_slide()
