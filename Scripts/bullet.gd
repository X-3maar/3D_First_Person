extends AnimatableBody3D

var dir
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dir = -global_transform.basis.z
	global_position += dir * 200 * delta
	

func _on_area_3d_body_entered(body: Node3D) -> void:
	call_deferred("queue_free")
