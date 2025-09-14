extends RigidBody2D

@export var speed = 500
@export var jump_power = 800

signal coins_changed(amount: int, player: Node2D)
signal score_changed(amount: int, player: Node2D)

var coins = 0
var score = 0

var ray: RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ray = $RayCast2D
	$Camera2D.make_current()
	coins_changed.emit(coins, self)
	score_changed.emit(score, self)

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
