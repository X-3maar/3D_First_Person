extends CanvasLayer
@onready var online: Button = $Online
@onready var button_2: Button = $Button2
@onready var label: Label = $Label
@onready var color_rect_2: ColorRect = $ColorRect2
@onready var button_3: Button = $Button3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/online.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu1.tscn")


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/offline.tscn")


func _on_online_pressed() -> void:
	button_2.hide()
	label.hide()
	online.hide()
	color_rect_2.show()
	button_3.hide()


func _on_host_3_pressed() -> void:
	button_2.show()
	label.show()
	online.show()
	color_rect_2.hide()
	button_3.show()


func _on_button_x_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/online.tscn")
