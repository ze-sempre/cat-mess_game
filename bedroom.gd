extends Control


const cursor_click = preload("res://assets/paw_cursor_click.png")
const cursor_normal = preload("res://assets/paw_cursor_normal.png")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left_mouse"):
		Input.set_custom_mouse_cursor(cursor_click,Input.CURSOR_ARROW, Vector2(32,32))
	if Input.is_action_just_released("left_mouse"):
		Input.set_custom_mouse_cursor(cursor_normal,Input.CURSOR_ARROW, Vector2(32,32))
		
