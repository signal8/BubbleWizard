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

func _process(delta: float) -> void:
	match currentState:
		0: #Roaming
			pass
		1: #Captured
			sprite.rotation += 1 * delta
		2: #Dead
			pass
	

func capture():
	if currentState == 1: return
	
	sprite.scale = Vector2(0.5,0.5)
	bubbleSprite.visible = true
	collision.set_deferred("disabled", true)
	await get_tree().process_frame
	bubbleCollision.set_deferred("disabled", false)
	currentState = 1
