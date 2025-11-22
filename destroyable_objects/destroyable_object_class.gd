extends Node2D
class_name DestroyableObjectClass

signal object_destroyed

@export var collision_area: Area2D
@export var shard_emitter: ShardEmitter

var destroyed: bool = false
func _ready() -> void:
	collision_area.area_entered.connect(on_collision_area_entered)
	
	
func on_collision_area_entered(area: Area2D):
	if !destroyed:
		if shard_emitter:
			shard_emitter.shatter()
		object_destroyed.emit()
		destroyed = true

	
