extends CharacterBody2D

@export var bubble : PackedScene
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var firing_rate = 0.5

var queued_direction = 1
@onready var timer = $Timer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
		queued_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("bubble") and timer.is_stopped():
		shootBubble(queued_direction)
		timer.start(firing_rate)

	move_and_slide()

func shootBubble(d):
	var b = bubble.instantiate()
	add_child(b)
	b.direction = d
	

func propel():
	velocity.y -= 9000
	print_debug("LAUNCH")
