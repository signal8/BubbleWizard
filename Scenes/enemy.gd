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


@export var type = 0

const SPEED = 100
var direction = -1

@export var currentState : state
var currentType : int

@export var greenTexture : Texture2D
@export var brownTexture : Texture2D
@export var redTexture : Texture2D
@export var purpleTexture : Texture2D

@export var greenTextureBubble : Texture2D
@export var brownTextureBubble : Texture2D
@export var redTextureBubble : Texture2D
@export var purpleTextureBubble : Texture2D

var collider

func _ready() -> void:
	match currentType:
		0: #acid
			sprite.texture = greenTexture
			bubbleSprite.texture = greenTextureBubble
		1: #mud
			sprite.texture = brownTexture
			bubbleSprite.texture = brownTextureBubble
		2: #wind
			sprite.texture = redTexture
			bubbleSprite.texture = redTextureBubble
		3: #gum
			sprite.texture = purpleTexture
			bubbleSprite.texture = purpleTextureBubble


func _physics_process(delta: float) -> void:
	match currentState:
		state.ROAMING: #Roaming
			if not is_on_floor():
				velocity += get_gravity() * delta
			velocity.x = SPEED * direction
			collider = move_and_collide(Vector2(velocity.x * delta, velocity.y))
		state.CAPTURED: #Captured
			match currentType:
				0:
					collider = move_and_collide(Vector2(0, -SPEED * delta))
					if collider != null:
						if collider.get_collider().is_in_group("destructable"):
							collider.get_collider().queue_free()
						queue_free()
				1:
					pass
				2:
					pass
				3:
					pass
		state.DEAD: #Dead
			pass
	
	if velocity.x == 0:
		direction *= -1



func capture():
	if currentState == 1: return
	
	bubbleSprite.visible = true
	sprite.visible = false
	collision.set_deferred("disabled", true)
	await get_tree().process_frame
	bubbleCollision.set_deferred("disabled", false)
	velocity = Vector2.ZERO
	currentState = 1


### DANGER ZONE
func bubblegum_collision(body: Node):
	if body.is_in_group("player"):
		body.velocity = Vector2.ZERO  
		body.position = global_position  
		print_debug("Touch")
	elif body.is_in_group("platforms"):
		body.position = global_position
