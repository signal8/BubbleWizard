extends Area2D

@export var SPEED = 300
var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position.x += SPEED * delta * direction

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	body.capture()
	queue_free()
