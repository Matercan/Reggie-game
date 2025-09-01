extends Node

@onready var enemyspawner := enemy_spawner.new()
@onready var reggie: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]

var timer = 0.0
var is_wating = true

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
func _ready() -> void:
	print("Hello world")
	add_child(enemyspawner)
	#enemyspawner.SpawnEnemies("placeholder",
	# enemyspawner.calculateposition(reggie.global_position, 100, 10))
	print("Enemy spawner has spawned some shit")
	wait(3)
	set_process(true)

func _process(delta: float) -> void:
	#print("Enemy spawn timer: ", timer)
	if is_wating:
		timer += delta
		if timer >= 3:
			is_wating = false
			timer = 0
	else:
		if randi_range(1, 4) > 1:
			enemyspawner.SpawnEnemies("placeholder",
			enemyspawner.calculateposition(reggie.global_position, 100, 20))
		else:
			enemyspawner.SpawnEnemies("wizard",
			enemyspawner.calculateposition(reggie.global_position, 100, 20))
		print("Enemy spawner has spawned some shit")
		is_wating = true
	
