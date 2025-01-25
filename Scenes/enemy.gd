extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var bubbleSprite = $BubbleSprite
@onready var collision = $CollisionShape2D
@onready var bubbleCollision = $BubbleCollision

enum state {
	ROAMING,
	CAPTURED,
	DEAD
}

@export var currentState : state

func _process(delta: float) -> void:
	match currentState:
		0: #Roaming
			pass
		1: #Captured
			rotation += 3000
		2: #Dead
			pass

func capture():
	if currentState == 1: return
	
	sprite.scale = Vector2(1,0.5)
	bubbleSprite.visible = true
	collision.set_deferred("disabled", true)
	await get_tree().process_frame
	bubbleCollision.set_deferred("disabled", false)
	currentState = 1
