extends Node3D
@onready var shooter: Marker3D = $"."

const BULLET = preload("uid://dl5uh1glkohgb")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bullet = BULLET.instantiate()
	shooter.add_child(bullet)
	bullet.global_transform = shooter.global_transform
	
