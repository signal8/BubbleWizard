extends CharacterBody2D

enum direction {
	UP_DOWN,
	LEFT_RIGHT,
	DIAGONAL1,
	DIAGONAL2
}

@export var currentDirection : direction

func _physics_process(delta: float) -> void:
	match currentDirection:
		direction.UP_DOWN:
			pass
		direction.LEFT_RIGHT:
			pass
		direction.DIAGONAL1:
			pass
		direction.DIAGONAL2:
			pass
