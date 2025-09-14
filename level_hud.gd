extends CanvasLayer

@export var coins_text_format = "Coins: %d"
@export var score_text_format = "Score: %d"
@export var health_text_format = "Health: %d / %d"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_level_player_spawned(player: Node2D) -> void:
	player.connect("coins_changed", Callable(self, "_on_player_coins_changed"))
	player.connect("score_changed", Callable(self, "_on_player_score_changed"))
	player.connect("health_changed", Callable(self, "_on_player_health_changed"))

func _on_player_coins_changed(amount: int, player: Node2D) -> void:
	$CoinsText.text = coins_text_format % [amount]

func _on_player_score_changed(amount: int, player: Node2D) -> void:
	$ScoreText.text = score_text_format % [amount]

func _on_player_health_changed(health: int, max_health: int, player: Node2D) -> void:
	$HealthText.text = health_text_format % [health, max_health]
