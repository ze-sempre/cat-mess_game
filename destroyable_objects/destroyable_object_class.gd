extends RigidBody2D
class_name DestroyableObjectClass

signal object_destroyed

@export var collision_area: Area2D
@export var shard_emitter: ShardEmitter
@export var breaking_sfx: AudioStreamPlayer2D

var destroyed: bool = false
func _ready() -> void:
	collision_area.area_entered.connect(on_collision_area_entered)
	
	
func on_collision_area_entered(area: Area2D):
	if !destroyed:
		if shard_emitter:
			shard_emitter.shatter()
		object_destroyed.emit()
		destroyed = true
		set_collision_layer_value(3, false)
		if breaking_sfx:
			breaking_sfx.pitch_scale = randf_range(0.9, 1.1)
			breaking_sfx.play()
	
