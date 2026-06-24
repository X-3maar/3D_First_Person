extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pistol_player: AnimationPlayer = $PistolPlayer
@onready var color_rect: ColorRect = $"../CanvasLayer/ColorRect"
@onready var color_rect_2: ColorRect = $"../CanvasLayer/ColorRect2"

var SPEED = 5.0
const JUMP_VELOCITY = 4.5
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
	if Input.is_action_just_pressed("esc") and !paused:
		color_rect.show()
		color_rect_2.show()
		Engine.time_scale = 0.0
		paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.is_action_just_pressed("esc") and paused:
		color_rect.hide()
		color_rect_2.hide()
		Engine.time_scale = 1.0
		paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("ctrl") and captured:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		captured = false
	elif Input.is_action_just_pressed("ctrl") and !captured:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		captured = true
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	var direction := (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and Input.is_action_pressed("run"):
		running = true
	else:
		running = false
	if running:
		SPEED = 10
		animation_player.speed_scale = 1.5
		pistol_player.speed_scale = 1.5
	else:
		SPEED = 5
		animation_player.speed_scale = 1.0
		pistol_player.speed_scale = 1.0
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_on_floor():
			animation_player.play("walk")
			pistol_player.play("walk")
		else:
			animation_player.stop()
		

	elif Input.is_action_just_released("move_back") or Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right") or Input.is_action_just_released("move_front"):
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		animation_player.stop()
		pistol_player.stop()
		
	move_and_slide()


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_conitnue_pressed() -> void:
	color_rect.hide()
	color_rect_2.hide()
	Engine.time_scale = 1.0
	paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_button_pressed() -> void:
	color_rect.show()
	color_rect_2.show()
	Engine.time_scale = 0.0
	paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
