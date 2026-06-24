extends Area3D

var dis=0
var speed = 60
var max = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	position += -transform.basis.z * speed * delta
	dis += delta * speed
	if dis > max:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	body.queue_free()
