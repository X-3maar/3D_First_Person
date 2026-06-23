extends Area3D

const speed = 60.0
const range = 40.0
var dis = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += -transform.basis.z * speed * delta
	dis += delta * speed
	if dis > 40:
		queue_free()
