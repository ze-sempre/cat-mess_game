extends Node2D
class_name DestroyableObjectClass

@export var collision_area: Area2D
@export var shard_emitter: ShardEmitter

func _ready() -> void:
	collision_area.area_entered.connect(on_collision_area_entered)
	
	
func on_collision_area_entered(area: Area2D):
	shard_emitter.shatter()
	#queue_free()
