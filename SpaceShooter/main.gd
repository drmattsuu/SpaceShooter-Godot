extends Node2D

@export var baddie_scene: PackedScene

var score = 0
var highScore = 0

func _update_label():
    var scoreLabel = ($GameUI/ScoreValueLabel as RichTextLabel)
    if scoreLabel:
        scoreLabel.text = str(score)

func incr_score(by: int):
    score += by
    _update_label()

func set_score(s: int):
    score = s
    _update_label()


func start_game():
    $Player.position = $SpawnPoint.position
    $Player.show()
    $StartUI.visible = false
    $GameUI.visible = true
    if score > highScore:
        highScore = score
    set_score(0)
    $BaddieTimer.start()

func _ready():
    $Player.hide()
    $GameUI.visible = false
    $StartUI.visible = true
    await get_tree().create_timer(3.0).timeout
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
        var spawnFollower = ($ScreenTop/Follower as PathFollow2D)
        spawnFollower.progress_ratio = randf_range(0.25, 0.75)
        var newBaddie = baddie_scene.instantiate()
        newBaddie.position = spawnFollower.position
        newBaddie.killed.connect(_baddie_killed)
        $Baddies.add_child(newBaddie)

func _baddie_killed():
    incr_score(1)
