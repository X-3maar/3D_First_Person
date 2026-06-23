extends CharacterBody3D
@onready var node_3d: Node3D = $Node3D
@onready var camera_3d: Camera3D = $Node3D/Camera3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $"../CanvasLayer/ColorRect"
@onready var button: Button = $"../CanvasLayer/Button"
@onready var color_rect_2: ColorRect = $"../CanvasLayer/ColorRect2"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../CanvasLayer/AnimatedSprite2D"
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2

var is_paused = false
var is_locked = true
var target= 75
var SPEED = 20
var JUMP_VELOCITY = 40
var sprint  = false
func _unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:

			if event is InputEventMouseMotion:
				node_3d.rotate_y(-event.relative.x * 0.005)
				camera_3d.rotate_x(-event.relative.y * 0.005)
			camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-60), deg_to_rad(70))
			camera_3d.rotation.z = 0
			node_3d.rotation.z = 0
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("ctrl") and is_locked:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		is_locked = false
		animated_sprite_2d.hide()
	elif Input.is_action_just_pressed("ctrl") and !is_locked:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		is_locked = true
		animated_sprite_2d.show()
		
	if not is_on_floor():
		velocity += get_gravity() * delta * 10

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("run") and Input.is_action_pressed("move_front"):
		SPEED = 40
		target = 100
		if !sprint:
			animation_player.play("sprintin")
			animation_player_2.play("fast")
			sprint = true
	elif Input.is_action_just_released("run"):
		SPEED = 20
		target = 75
		if sprint:
			animation_player.play("sprintout")
			animation_player_2.play("idle")
			sprint = false
	camera_3d.fov = target
	var input_dir := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	var direction = (node_3d.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if Input.is_action_just_pressed("esc") and !is_paused:
		color_rect.show()
		button.hide()
		color_rect_2.show()
		is_paused = true
		animated_sprite_2d.hide()
		Engine.time_scale = 0.0
	elif Input.is_action_just_pressed("esc") and is_paused:
		Engine.time_scale = 1.0
		is_paused = false
		color_rect.hide()
		color_rect_2.hide()
		button.show()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		animated_sprite_2d.show()
	if is_paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	

	move_and_slide()

func _on_button_pressed() -> void:
	color_rect.show()
	color_rect_2.show()
	button.hide()
	Engine.time_scale = 0.0
	is_paused = true


func _on_conitnue_pressed() -> void:
	color_rect.hide()
	color_rect_2.hide()
	button.show()
	Engine.time_scale = 1.0
	is_paused = false

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	

	
	
