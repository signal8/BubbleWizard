extends Area2D

var gunked = false
@onready var timer = $Timer
@export var arrow : PackedScene

func _process(delta: float) -> void:
	if gunked: return
	elif timer.is_stopped():
		var a = arrow.instantiate()
		add_child(a)
		timer.start(1)
		

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("gum"):
		gunked = true
		print_debug("gum time")
