extends CollisionShape2D

@onready var player = get_node("/root/Player") # Assuming player is a node in the scene
@onready var bubbleType = $BubbleCollision  # Reference to the bubble collision area
@onready var bubbleSprite = $BubbleSprite  # Reference to the bubble sprite
@onready var parent = $"../Enemy"

var currentType : int
var isAbsorbed : bool = false

func _ready():
	parent = get_parent()
	currentType = parent.type
	
	# Initialize bubble type and other properties
	match currentType:
		0:
			pass
		1:
			pass
		2:
			pass
		3:
			pass

# Detect collisions with player or other objects
func _on_BubbleCollision_body_entered(body: Node):
	if body.is_in_group("player"):  
		if currentType == 3:
			bubblegum_collision(body)
		elif currentType == 0:
			acid_collision(body)
		elif currentType == 1:
			mud_collision(body)
		elif currentType == 2:
			wind_collision(body)
				
func bubblegum_collision(body: Node):
	if body.is_in_group("player"):
		# The player sticks to the bubblegum
		body.velocity = Vector2.ZERO  # Stop the player's movement
		body.position = global_position  # Attach the player to the bubble
		body.scale = Vector2(0.5, 0.5)  # Optionally shrink the player
	elif body.is_in_group("platforms"):
		# Make platforms stick to the bubblegum
		body.velocity = Vector2.ZERO  # Stop platform movement
		body.position = global_position  # Attach the platform to the bubble
		body.scale = Vector2(0.5, 0.5)  # Optionally shrink platforms


func acid_collision(body: Node):
	if body.is_in_group("player"):
		# Kill the Player
		body.queue_free()  
	elif body.is_in_group("steel"):
		# Melt objects
		body.queue_free() 
	self.velocity = Vector2(0, -50) 


func mud_collision(body: Node):
	if body.is_in_group("mud_bubbles") and not isAbsorbed:
		# Absorb the other mud bubble to grow in size
		self.scale += Vector2(0.2, 0.2)  # Increase size to simulate absorption
		isAbsorbed = true
		body.queue_free()  # Destroy the absorbed mud bubble

func wind_collision(body: Node):
	if body.is_in_group("objects"):
		var force = Vector2(0, 100)  
		body.apply_impulse(Vector2.ZERO, force)
