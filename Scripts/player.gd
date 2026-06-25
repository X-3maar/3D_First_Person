extends CharacterBody3D
const BULLET = preload("uid://dl5uh1glkohgb")

@onready var color_rect: ColorRect = $"../CanvasLayer/ColorRect"
@onready var color_rect_2: ColorRect = $"../CanvasLayer/ColorRect2"
@onready var shooter: Marker3D = $Neck/Camera3D/Pistol/Shooter
@onready var camera: AnimationPlayer = $Camera
@onready var pistol: AnimationPlayer = $Pistol
@onready var button: Button = $"../CanvasLayer/Button"
@onready var cross_hair: AnimatedSprite2D = $"../CanvasLayer/CrossHair"
var aiming = false
var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var moving
var captured = true
var running = true
var paused = false
@onready var neck: Node3D = $Neck
@onready var camera_3d: Camera3D = $Neck/Camera3D

func _unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera_3d.rotate_x(-event.relative.y * 0.01)
			camera_3d.rotation.x = clamp(camera_3d.rotation.x,deg_to_rad(-60),deg_to_rad(60))

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	var direction := (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction.length() > 0:
		moving = true
	else:
		moving = false
	if moving and !aiming and !pistol.is_playing():
		camera.play("Walk")
	elif !moving and !aiming and !camera.is_playing() and camera_3d.fov == 60:
		camera.stop()
	if !moving and camera.current_animation == "Walk":
		camera.stop()
	if Input.is_action_just_pressed("aim") and !aiming:
		camera.stop()
		pistol.play("aimin")
		camera.play("aimin")
		aiming = true
		
	elif Input.is_action_just_pressed("aim") and aiming:
		pistol.play("aimout")
		camera.play("aimout")
		aiming = false
		
	if Input.is_action_just_pressed("esc") and !paused:
		color_rect.show()
		color_rect_2.show()
		Engine.time_scale = 0.0
		paused = true
		button.hide()
		cross_hair.hide()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.is_action_just_pressed("esc") and paused:
		color_rect.hide()
		color_rect_2.hide()
		Engine.time_scale = 1.0
		paused = false
		button.show()
		cross_hair.show()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("ctrl") and captured:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		captured = false
		cross_hair.hide()
	elif Input.is_action_just_pressed("ctrl") and !captured:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		captured = true
		if !paused:
			cross_hair.show()
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if direction and Input.is_action_pressed("run"):
		running = true
	else:
		running = false		
		
	if running:
		camera.speed_scale = 2.0
		SPEED = 10
	else:
		camera.speed_scale = 1.0
		SPEED = 5
			
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	move_and_slide()

func _on_exit_pressed() -> void:
	Engine.time_scale = 1.0
	get_tree().change_scene_to_file("res://Scenes/menu1.tscn")

func _on_conitnue_pressed() -> void:
	color_rect.hide()
	color_rect_2.hide()
	Engine.time_scale = 1.0
	paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	button.show()
	cross_hair.show()

func _on_button_pressed() -> void:
	color_rect.show()
	color_rect_2.show()
	Engine.time_scale = 0.0
	button.hide()
	cross_hair.hide()
	paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func shoot():
	var bullet = BULLET.instantiate()
	shooter.add_child(bullet)
	bullet.global_transform = shooter.global_transform
