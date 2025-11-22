extends Control
class_name LevelUI

@export var destroyable_objects_container: Node2D

@onready var object_amount_label: Label = %object_amount_label

var total_object_amount: int
var current_object_amount: int

func _ready() -> void:
	total_object_amount = destroyable_objects_container.get_child_count()
	current_object_amount = total_object_amount
	for child in destroyable_objects_container.get_children():
		child.object_destroyed.connect(on_object_destroyed)

func _process(delta: float) -> void:
	object_amount_label.text = str(current_object_amount) + "/" + str(total_object_amount)

func on_object_destroyed():
	current_object_amount -= 1
	if current_object_amount <= 0:
		Global.level_complete.emit()
