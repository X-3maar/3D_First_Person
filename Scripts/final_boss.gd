extends CharacterBody3D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
var count = 0
var ins = false
func _on_area_3d_area_entered(area: Area3D) -> void:
	animation_player.speed_scale = 2.0
	count += 1
	if count == 1:
		animation_player.play("right")
	elif count == 2:
		animation_player.play("left")
	elif count == 3:
		animation_player.play("middle")
		count = 0
func _physics_process(delta: float) -> void:
	if ins:
		animation_player.play("right")

		animation_player.play("left")

		animation_player.play("middle")

	
