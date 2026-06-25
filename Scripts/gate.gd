extends CSGBox3D

@onready var target: Area3D = $"../Target"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	if !target:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
