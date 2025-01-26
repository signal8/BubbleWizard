extends CharacterBody2D

@export var bubble : PackedScene
@export var title : PackedScene
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -600.0
@export var firing_rate = 0.5

var queued_direction = 1
@onready var timer = $Timer
@onready var audio = $AudioStreamPlayer
@onready var walk  = $pantera_walk
var collider
var dying = false

func _physics_process(delta: float) -> void:
	if dying == true: return
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
		if walk.playing == false and is_on_floor():
			walk.pitch_scale = randf_range(0.8, 1.2)
			walk.play()
		velocity.x = direction * SPEED
		queued_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("bubble") and timer.is_stopped():
		audio.play()
		shootBubble(queued_direction)
		timer.start(firing_rate)
	
	move_and_slide()
	for i in get_slide_collision_count():
		collider = get_slide_collision(i)
		if collider.get_collider().is_in_group("killer") and not dying: die()



func shootBubble(d):
	var b = bubble.instantiate()
	add_child(b)
	b.direction = d
	

func propel():
	velocity.y -= 1000
	print_debug("LAUNCH")

func die():
	dying = true
	get_tree().reload_current_scene()
