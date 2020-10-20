extends Camera

var speed = 30

export var target_path: NodePath

func _process(delta):
	var target_object = get_node(target_path);
	var horizontal_axis = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var vertical_axis = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	self.translate(Vector3.RIGHT * delta * speed * horizontal_axis)
	self.translate(Vector3.DOWN * delta * speed * vertical_axis)
	self.look_at(target_object.global_transform.origin, Vector3.UP)
