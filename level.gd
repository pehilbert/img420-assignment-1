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

func _on_player_spawned(player: Node2D) -> void:
	player.connect("death", Callable(self, "_on_player_death"))

func _on_player_death(player: Node2D) -> void:
	$RespawnTimer.start()
	
func _on_respawn_timer_timeout() -> void:
	spawn_player()
