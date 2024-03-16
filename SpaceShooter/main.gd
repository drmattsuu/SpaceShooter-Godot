extends Node2D

@export var baddie_scene: PackedScene

var score = 0

func start_game():
    $Player.position = $SpawnPoint.position
    $Player.show()
    score = 0
    $BaddieTimer.start()

func _ready():
    $Player.hide()
    # await get_tree().create_timer(3.0).timeout
    start_game()

func _on_player_hit(body):
    if body.get_parent() == $Baddies:
        print("Player Hit")
        $Player.hide()
        for baddie in $Baddies.get_children():
            baddie.queue_free()
        $BaddieTimer.stop()
        print("Restarting...")
        await get_tree().create_timer(3.0).timeout
        start_game()

func _on_baddie_timer_timeout():
    if baddie_scene.can_instantiate():
        var newBaddie = baddie_scene.instantiate()
        newBaddie.position = $BaddieSpawnPoint.position
        newBaddie.look_at($SpawnPoint.position)
        newBaddie.killed.connect(_baddie_killed)
        $Baddies.add_child(newBaddie)

func _baddie_killed():
    score += 1
    print(score)
