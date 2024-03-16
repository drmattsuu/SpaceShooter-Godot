extends CharacterBody2D

var max_speed = 100

signal bullet_hit
signal killed

# Overrides
func _ready():
    velocity = Vector2(randf_range(-max_speed * 0.5, max_speed * 0.5), randf_range(0, max_speed))

func _physics_process(_delta):
    velocity = velocity.limit_length(max_speed)
    move_and_slide()

# Callbacks
func _on_bullet_hit():
    killed.emit()
    queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
    queue_free()
