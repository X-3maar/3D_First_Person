extends Area3D
var count = 0
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
# Called when the node enters the scene tree for the first time.
@onready var animation_player: AnimationPlayer = $"../Gate/AnimationPlayer"
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if count == 3:
		animation_player.play("open")
		process_mode = PROCESS_MODE_DISABLED



func _on_area_entered(area: Area3D) -> void:
	count += 1
