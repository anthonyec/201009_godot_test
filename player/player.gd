extends KinematicBody

onready var debug_overlay = get_node("/root/DebugOverlay")

var speed: float = 5

func _ready():
	print("Player ready")

func _process(delta: float):
	var direction: Vector3 = Vector3(0, 0, 0)

	var verticalAxis = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var horizontalAxis = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	direction += Vector3(horizontalAxis, 0, verticalAxis) * speed

	var player_position = self.global_transform.origin;
	debug_overlay.draw.add_vector(player_position, player_position + direction, 3, Color(1, 0, 0, 1))

	move_and_collide(direction * delta)


func _input(event):
	if event.is_action_pressed("move_left"):
		print("move_left")
