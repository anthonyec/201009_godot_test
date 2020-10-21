extends Camera

var speed: float = 30
var rotate_speed: float = 5
var is_aiming: bool = false
var mouse_relative_position: Vector2
var mouse_sensitivity: float = 1

export var target_path: NodePath
export var orbit: bool

func _process(delta):
	var target_object = get_node(target_path);

	var horizontal_axis = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var vertical_axis = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var camera_horizontal_axis = Input.get_action_strength("camera_right") - Input.get_action_strength("camera_left")
	var camera_vertical_axis = Input.get_action_strength("camera_down") - Input.get_action_strength("camera_up")

	if orbit:
		self.translate(Vector3.RIGHT * delta * speed * horizontal_axis)
		self.translate(Vector3.DOWN * delta * speed * vertical_axis)
		self.look_at(target_object.global_transform.origin, Vector3.UP)
	else:
		self.translate(Vector3.FORWARD * delta * speed * -vertical_axis)
		self.translate(Vector3.RIGHT * delta * speed * horizontal_axis)
		self.rotate_object_local(Vector3.RIGHT, -camera_vertical_axis * delta * rotate_speed)
		self.rotate(Vector3.UP, -camera_horizontal_axis * delta * rotate_speed)

		if is_aiming:
			self.rotate_object_local(Vector3.RIGHT, -floor(mouse_relative_position.y) * delta * mouse_sensitivity)
			self.rotate(Vector3.UP, -floor(mouse_relative_position.x) * delta * mouse_sensitivity)

			# Reset to zero because when mouse stops moving, relative position does
			# not always return to zero.
			# https://godotengine.org/qa/61349/how-to-detect-if-the-mouse-has-stopped-moving
			mouse_relative_position = Vector2.ZERO


func _input(event):
	if event is InputEventMouseMotion:
		mouse_relative_position = event.relative

	if event.is_action_pressed("camera_aim"):
		is_aiming = true

	if event.is_action_released("camera_aim"):
		is_aiming = false



