extends CharacterBody2D


@export var move_speed = 300.0

@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descend: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descend * jump_time_to_descend)) * -1.0

@onready var movement_anim: AnimationPlayer = $movement_anim
@onready var body: Sprite2D = $body
@onready var head: Sprite2D = $head
@onready var jump_buffer_timer: Timer = $jump_buffer_timer





func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += get_custom_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer.start()
		
	if is_on_floor() and !jump_buffer_timer.is_stopped():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * move_speed 
		movement_anim.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		movement_anim.play("idle")
		
	move_and_slide()
	
	if direction > 0.0:
		body.flip_h = true
		head.flip_h = true
	elif direction < 0.0:
		body.flip_h = false
		head.flip_h = false

func get_custom_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
