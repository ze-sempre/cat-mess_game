extends CharacterBody2D
class_name Player

@export var move_speed = 300.0

@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descend: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descend * jump_time_to_descend)) * -1.0

@onready var movement_anim: AnimationPlayer = $movement_anim
@onready var body: AnimatedSprite2D = $body
@onready var head: AnimatedSprite2D = $head
@onready var jump_buffer_timer: Timer = $jump_buffer_timer
@onready var attack_collision: CollisionShape2D = $attack_area/attack_collision
@onready var attack_sweep: AnimatedSprite2D = $attack_sweep
@onready var attack_anim: AnimationPlayer = $attack_anim
@onready var attack_right: Marker2D = $attack_right
@onready var attack_left: Marker2D = $attack_left
@onready var attack_area: Area2D = $attack_area
@onready var level_cleared_anim: AnimationPlayer = $level_cleared_anim


@export var can_move:bool = true

func _ready() -> void:
	Global.player = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += get_custom_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer.start()
		
	if is_on_floor() and !jump_buffer_timer.is_stopped():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and can_move:
		velocity.x = direction * move_speed 
		movement_anim.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		movement_anim.play("idle")
		
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
	if direction > 0.0:
		body.flip_h = true
		head.flip_h = true
		attack_sweep.flip_h = true
		attack_sweep.position = attack_right.position
		attack_area.scale = Vector2.ONE
	elif direction < 0.0:
		body.flip_h = false
		head.flip_h = false
		attack_sweep.flip_h = false
		attack_sweep.position = attack_left.position
		attack_area.scale = Vector2(-1, 1)
		
func get_custom_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func attack():
	attack_anim.play("attack")
