extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Bgm1.playing:
		Bgm1.play()
		Bgm2.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
