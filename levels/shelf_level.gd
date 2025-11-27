extends Node2D

@onready var circle_transition_screen: CircleTransitionScreen = $CanvasLayer/circle_transition_screen

func _ready() -> void:
	circle_transition_screen.fade_from_black()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await circle_transition_screen.fade_to_black()
	get_tree().reload_current_scene()
