extends Control
class_name LevelUI

@export var destroyable_objects_container: Node2D

@onready var object_amount_label: Label = %object_amount_label
@onready var circle_transition_screen: CircleTransitionScreen = $"../circle_transition_screen"

var total_object_amount: int
var current_object_amount: int

func _ready() -> void:
	total_object_amount = destroyable_objects_container.get_child_count()
	current_object_amount = total_object_amount
	for child in destroyable_objects_container.get_children():
		child.object_destroyed.connect(on_object_destroyed)
	Global.level_complete.connect(on_level_complete)

func _process(delta: float) -> void:
	object_amount_label.text = str(current_object_amount) + "/" + str(total_object_amount)

func on_object_destroyed():
	current_object_amount -= 1
	if current_object_amount <= 0:
		Global.level_complete.emit()

func on_level_complete():
	await get_tree().create_timer(.5).timeout
	Global.player.level_cleared_anim.play("level_cleared")
	await Global.player.level_cleared_anim.animation_finished
	await circle_transition_screen.fade_to_black()
	get_tree().change_scene_to_file("res://bedroom.tscn")
