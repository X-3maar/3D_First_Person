extends CSGBox3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var timer = 0
func _process(delta: float) -> void:
	
	if Global.gate:
		animation_player.play("open")
		await animation_player.animation_finished
		animation_player.play("close")
		Global.gate = false
			
