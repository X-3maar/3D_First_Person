extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Bgm2.playing:
		Bgm1.stop()
		Bgm2.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
