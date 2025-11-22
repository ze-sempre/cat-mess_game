extends Node2D

@onready var circle_transition_screen: CircleTransitionScreen = $CanvasLayer/circle_transition_screen

func _ready() -> void:
	circle_transition_screen.fade_from_black()
