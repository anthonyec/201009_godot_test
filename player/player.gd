extends KinematicBody

onready var debug_overlay = get_node("/root/DebugOverlay")

var speed: float = 5

func _ready():
	pass

func _process(delta: float):
	var direction: Vector3 = Vector3(0, 0, 0)

	var horizontalAxis = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var verticalAxis = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	var error = 1.1

	var input = Vector2(
		clamp(horizontalAxis * error, -1, 1),
		clamp(verticalAxis * error, -1, 1)
	);

	var inputCircle = Vector2(
		input.x * sqrt(1 - input.y * input.y * 0.5),
		input.y * sqrt(1 - input.x * input.x * 0.5)
	)

	# inputCircle = inputCircle.normalized()

	direction += Vector3(inputCircle.x, 0, inputCircle.y) * speed

	var player_position = self.global_transform.origin;

	debug_overlay.draw.add_vector(player_position, player_position + direction, 3, Color(1, 0, 0, 1))
	move_and_collide(direction * delta)
