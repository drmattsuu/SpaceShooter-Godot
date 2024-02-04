extends Node2D

@export var baddie_scene: PackedScene

func start_game():
	var player = $Player
	player.position = $SpawnPoint.position
	player.show()

func _ready():
	$Player.hide()
	await get_tree().create_timer(3.0).timeout
	start_game()

