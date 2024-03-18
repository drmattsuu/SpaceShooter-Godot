extends CharacterBody2D

var speed = 150
var boost_speed = 200
var screen_ratio_to_chase = 0.25
var target: Node2D = null

signal bullet_hit
signal killed

# Overrides
func _ready():
    velocity = Vector2(randf_range(-speed, speed), speed)

func _physics_process(_delta):
    if target:
        velocity = position.direction_to(target.position)
        velocity *= boost_speed
    else:
        velocity = velocity.limit_length(speed)

    move_and_slide()

func _process(_delta):
    if target != null:
        look_at(target.position)
        return

    look_at(position + velocity)
    var screenYSize = get_viewport_rect().size.y
    if position.y > (screenYSize * screen_ratio_to_chase):
        target = get_tree().get_first_node_in_group("player") as Node2D

# Callbacks
func _on_bullet_hit():
    killed.emit()
    queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
    queue_free()
