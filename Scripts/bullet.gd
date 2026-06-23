extends Area3D


# Called when the node enters the scene tree for the first time.
const speed = 55
const range = 40
var dis = 0
func _physics_process(delta: float) -> void:
	position += -transform.basis.z * speed * delta
	dis += speed * delta
	if dis > 40:
		queue_free()
func _on_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
