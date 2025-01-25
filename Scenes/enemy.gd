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

enum type {
	GREEN,
	BROWN,
	RED,
	PURPLE
}

const SPEED = 100
var direction = -1

@export var currentState : state
@export var currentType : type

@export var greenTexture : Texture2D
@export var brownTexture : Texture2D
@export var redTexture : Texture2D
@export var purpleTexture : Texture2D



func _ready() -> void:
	match currentType:
		0: #Green
			sprite.texture = greenTexture
		1: #Brown
			sprite.texture = brownTexture
		2: #Red
			sprite.texture = redTexture
		3: #purple
			sprite.texture = purpleTexture



func _physics_process(delta: float) -> void:
	match currentState:
		0: #Roaming
			velocity.x = SPEED * direction
		1: #Captured
			sprite.rotation += 1 * delta
		2: #Dead
			pass
	
	move_and_slide()
	
	if velocity.x == 0:
		direction *= -1



func capture():
	if currentState == 1: return
	
	sprite.scale = Vector2(0.5,0.5)
	bubbleSprite.visible = true
	collision.set_deferred("disabled", true)
	await get_tree().process_frame
	bubbleCollision.set_deferred("disabled", false)
	velocity = Vector2.ZERO
	currentState = 1
