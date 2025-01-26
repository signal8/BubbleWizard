extends Area2D

var gunked = false

func _process(delta: float) -> void:
	if gunked: return
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("gum"):
		gunked = true
		print_debug("gum time")
