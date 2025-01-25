extends CharacterBody2D

enum direction {
	UP_DOWN,
	LEFT_RIGHT,
	DIAGONAL1,
	DIAGONAL2
}

@export var currentDirection : direction
var directionVector = 1
const SPEED = 200
var cachedVelocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	match currentDirection:
		direction.UP_DOWN:
			velocity.y = SPEED * directionVector
		direction.LEFT_RIGHT:
			pass
		direction.DIAGONAL1:
			pass
		direction.DIAGONAL2:
			pass
	
	if cachedVelocity.y == 0:
		directionVector = -1
	
	move_and_slide()
