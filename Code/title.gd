extends Control

@export var firstLevel : PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_packed(firstLevel)
