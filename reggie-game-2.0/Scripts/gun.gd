extends Node2D

@export var guntip: Sprite2D

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"): shoot()

func shoot() -> void:
	var gunshot: AudioStreamPlayer2D = $Gunshot
	gunshot.playing = true
	var inst: Projectile = get_parent().projectile.instantiate()
	owner.owner.add_child(inst)
	inst.transform = guntip.transform
	inst.position = guntip.global_position
	inst.scale = Vector2(0.1, 0.1)
