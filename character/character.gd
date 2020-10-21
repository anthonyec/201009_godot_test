extends KinematicBody

onready var debug_overlay = get_node("/root/DebugOverlay")

func _ready():
	pass

func _physics_process(delta):
	# var _collision = move_and_collide(Vector3(-1 * delta, 0, 1 * delta))
	var local_forward = -self.global_transform.basis.z

	var from = self.global_transform.origin
	var to = self.global_transform.origin + local_forward * 5
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(from, to)

	debug_overlay.draw.add_vector(
		from,
		to,
		1,
		Color(1, 0, 0, 1)
	)


	if result:
		debug_overlay.draw.add_vector(
			from,
			result.position,
			1,
			Color(0, 1, 0, 1)
		)

		debug_overlay.draw.add_vector(
			result.position,
			result.position + result.normal * 2,
			1,
			Color(0, 1, 0.5, 1)
		)

	pass
