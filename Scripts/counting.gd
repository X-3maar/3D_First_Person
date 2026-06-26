extends CSGMesh3D
@onready var animation_player: AnimationPlayer = $"../../Target/AnimationPlayer"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var speed = 1.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var counter = mesh as TextMesh	
	counter.text = str(Global.count)
	


func _on_target_area_entered(area: Area3D) -> void:
	speed += 0.05
	animation_player.speed_scale = speed
