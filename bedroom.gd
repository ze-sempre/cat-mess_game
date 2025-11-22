extends Control

const cursor_click = preload("res://assets/paw_cursor_click.png")
const cursor_normal = preload("res://assets/paw_cursor_normal.png")

@export var circle_transitio_screen: CircleTransitionScreen

@onready var bed: TextureButton = $bed
@onready var shelf: TextureButton = $shelf
@onready var carboard_box: TextureButton = $carboard_box

func _ready() -> void:
	circle_transitio_screen.fade_from_black()

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left_mouse"):
		Input.set_custom_mouse_cursor(cursor_click,Input.CURSOR_ARROW, Vector2(32,32))
	if Input.is_action_just_released("left_mouse"):
		Input.set_custom_mouse_cursor(cursor_normal,Input.CURSOR_ARROW, Vector2(32,32))
		

func _on_shelf_pressed() -> void:
	await circle_transitio_screen.fade_to_black()
	get_tree().change_scene_to_file("res://levels/shelf_level.tscn")
