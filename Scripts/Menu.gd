extends CanvasLayer

@onready var online: Button = $Online
@onready var button_2: Button = $Button2
@onready var label: Label = $Label
@onready var color_rect_2: ColorRect = $ColorRect2
@onready var ip: LineEdit = $ColorRect2/LineEdit

const PORT = 6760
var enet_peer = ENetMultiplayerPeer.new()

func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connection_success)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/online.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu1.tscn")

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/offline.tscn")

func _on_online_pressed() -> void:
	button_2.hide()
	label.hide()
	online.hide()
	color_rect_2.show()

func _on_host_3_pressed() -> void:
	button_2.show()
	label.show()
	online.show()
	color_rect_2.hide()

func _on_host_pressed() -> void:
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	load_game_scene()

func _on_join_pressed() -> void:

	enet_peer.create_client("local_host", PORT)

	multiplayer.multiplayer_peer = enet_peer

func _on_connection_success() -> void:
	load_game_scene()

func load_game_scene() -> void:
	get_tree().change_scene_to_file("res://Scenes/online.tscn")
