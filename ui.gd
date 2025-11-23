extends CanvasLayer

@onready var bed: ObjectClass = %bed
@onready var shelf: ObjectClass = %shelf
@onready var carboard_box: ObjectClass = %carboard_box
@onready var status_label: Label = %status_label
@onready var status_container: PanelContainer = %status_container

func _ready() -> void:
	status_container.scale = Vector2.ZERO
	
	bed.mouse_entered.connect(on_object_hover.bind(bed.object_name))
	bed.focus_entered.connect(on_object_hover.bind(bed.object_name))
	bed.mouse_exited.connect(on_object_hover_off)
	bed.focus_exited.connect(on_object_hover_off)
	
	shelf.mouse_entered.connect(on_object_hover.bind(shelf.object_name))
	shelf.focus_entered.connect(on_object_hover.bind(bed.object_name))
	shelf.focus_exited.connect(on_object_hover_off)
	shelf.mouse_exited.connect(on_object_hover_off)
	
	carboard_box.mouse_entered.connect(on_object_hover.bind(carboard_box.object_name))
	carboard_box.focus_entered.connect(on_object_hover.bind(bed.object_name))
	carboard_box.focus_exited.connect(on_object_hover_off)
	carboard_box.mouse_exited.connect(on_object_hover_off)
	
	
	


func on_object_hover(object_name: String):
	status_container.show()
	match object_name:
		"bed":
			status_label.text = "that's the big cat's bed"
		"shelf":
			status_label.text = "a shelf full of pushable stuff"
		"cardboard box":
			status_label.text = "my sweet bed"

func on_object_hover_off():
	status_container.hide()
