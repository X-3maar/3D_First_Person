extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var count = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.

	if count == 3:
		queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	count +=1
	
	
