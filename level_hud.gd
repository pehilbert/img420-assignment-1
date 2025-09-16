extends CanvasLayer

@export var coins_text_format = "Coins: %d"
@export var score_text_format = "Score: %d"
@export var health_text_format = "Health: %d / %d"
@export var main_menu_path = "res://main_menu.tscn"

signal respawn_button_pressed
signal play_again_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DeathScreen.visible = false
	$WinScreen.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_level_player_spawned(player: Node2D) -> void:
	player.connect("score_changed", Callable(self, "_on_player_score_changed"))
	player.connect("health_changed", Callable(self, "_on_player_health_changed"))
	player.connect("death", Callable(self, "_on_player_death"))
	player.connect("won_level", Callable(self, "_on_player_won_level"))

func _on_player_score_changed(amount: int, player: Node2D) -> void:
	$ScoreText.text = score_text_format % [amount]

func _on_player_health_changed(health: int, max_health: int, player: Node2D) -> void:
	$HealthText.text = health_text_format % [health, max_health]
	
func _on_player_death(player: Node2D):
	$DeathScreen/ScoreText.text = score_text_format % [player.score]
	$DeathScreen.visible = true
	
func _on_player_won_level(player: Node2D):
	$WinScreen/ScoreText.text = score_text_format % [player.score]
	$WinScreen.visible = true

func _on_respawn_pressed() -> void:
	get_tree().reload_current_scene()
	$DeathScreen.visible = false

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_path)
	$DeathScreen.visible = false
	$WinScreen.visible = false
	
func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()
	$WinScreen.visible = false
