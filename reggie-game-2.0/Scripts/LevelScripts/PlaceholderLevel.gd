extends Node

@onready var enemyspawner = enemy_spawner.new()
@onready var reggie: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
func _ready() -> void:
	print("Hello world")

func _physics_process(delta: float) -> void:
	enemyspawner.SpawnEnemies("placeholder", Vector2(150,0))
	print("Enemy spawner has spawned some shit")
	
	
