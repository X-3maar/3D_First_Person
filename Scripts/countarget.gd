extends Area3D



func _on_area_entered(area: Area3D) -> void:
	Global.counter += 1
	queue_free()
func _process(delta: float) -> void:
	if Global.counter == 5:
		Global.gate = true
		Global.counter = 0
		
