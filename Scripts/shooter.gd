extends Node3D

const bullet = preload("res://Scenes/bullet.tscn")
var mouse = true
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		var Bullet = bullet.instantiate()
		add_child(Bullet)
		mouse = false
		Bullet.global_position = global_position
		Bullet.global_transform = global_transform
		
	
