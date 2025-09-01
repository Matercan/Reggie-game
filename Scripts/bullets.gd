extends Area2D

class_name Projectile

@export var speed: float = 200
@onready var reggie = get_tree().get_nodes_in_group("player")[0]
@export var length: float = 10
@export var knockback: float = 5
@export var points: int = 0
@onready var time:float = 0
@onready var direction: Vector2 = find_gun_pos().normalized()
@onready var label = $Label

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	add_to_group("projectile")
	label.visible = false

func _physics_process(delta: float) -> void:
	move(delta)
	time += delta
	label.text = str(points)
	if (time >= length): free()
	
func find_gun_pos() -> Vector2:
	var gun = reggie.get_node("gun")  # Capitalization matters!
	var guntip = gun.get_node("Sprite2D")
	return guntip.global_position - gun.global_position
	
func move(delta: float) -> void:
	position += direction * speed * delta

	
func _on_impact_finished():
	queue_free()



	
