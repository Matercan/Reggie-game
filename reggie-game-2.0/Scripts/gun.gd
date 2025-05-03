extends Node2D

@onready var guntip: Sprite2D = get_child(0)

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"): shoot()

func shoot() -> void:
	var inst: Projectile = get_parent().projectile.instantiate()
	owner.owner.add_child(inst)
	inst.position = guntip.global_position
	inst.rotation = guntip.global_rotation
	inst.reggie = get_parent()
	inst.scale = Vector2(0.1, 0.1)
