extends RigidBody2D

@export var speed = 500
@export var jump_power = 800
@export var starting_health = 3

signal coins_changed(amount: int, player: Node2D)
signal score_changed(amount: int, player: Node2D)
signal health_changed(health: int, max_health: int, player: Node2D)
signal damaged(amount: int, player: Node2D)
signal healed(amount: int, player: Node2D)
signal death(player: Node2D)

var coins: int
var score: int
var health: int
var max_health: int
var invincible: bool

var ray: RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ray = $RayCast2D
	$Camera2D.make_current()
	
	score = 0
	coins = 0
	health = starting_health
	max_health = starting_health
	invincible = false
	
	coins_changed.emit(coins, self)
	score_changed.emit(score, self)
	health_changed.emit(health, max_health, self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	var input = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1

	input = input.normalized()
	linear_velocity.x = input.x * speed
	angular_velocity = 0
	rotation = 0
	
	if Input.is_action_just_pressed("jump") and ray.is_colliding():
		apply_impulse(Vector2.UP * jump_power)

func get_coins():
	return coins
	
func add_coins(amount: int):
	coins += amount
	coins_changed.emit(coins, self)

func get_score():
	return score
	
func add_score(amount: int):
	score += amount
	score_changed.emit(score, self)

func damage(amount: int):	
	if !invincible:
		if health - amount <= 0:
			health = 0
			die()
		else:
			iframes()
			health -= amount
			
	damaged.emit(amount, self)
	health_changed.emit(health, max_health, self)
	
func heal(amount: int):
	health = min(max_health, health + amount)
	healed.emit(amount, self)
	health_changed.emit(health, max_health, self)

func iframes():
	invincible = true
	$IFramesTimer.start()
	$AnimatedSprite2D.modulate = Color(1, 1, 1, 0.5) # 50% transparent

func _on_i_frames_timer_timeout() -> void:
	invincible = false
	$AnimatedSprite2D.modulate = Color(1, 1, 1, 1) # opaque
	
func die():
	death.emit(self)
	queue_free()
