extends Node2D

signal player_spawned(player: Node2D)

var PlayerScene = preload("res://player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_player():
	var player = PlayerScene.instantiate()
	player.global_position = $SpawnPoint.global_position
	player_spawned.emit(player)
	add_child(player)

func _on_level_hud_respawn_button_pressed() -> void:
	spawn_player()

func _on_level_hud_play_again_pressed() -> void:
	get_tree().reload_current_scene()
