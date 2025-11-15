extends CanvasLayer

@onready var bed: ObjectClass = %bed
@onready var shelf: ObjectClass = %shelf
@onready var carboard_box: ObjectClass = %carboard_box
@onready var status_label: Label = %status_label

func _ready() -> void:
	bed.mouse_entered.connect(func():status_label.text = "that's a bed")
	
