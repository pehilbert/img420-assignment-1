extends RigidBody2D

@export var speed = 800
@export var jump_power = 500
var ray: RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ray = $RayCast2D

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
