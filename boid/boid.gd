extends KinematicBody

var velocity = Vector3(rand_range(-0.2, 0.2), 0, rand_range(-0.2, 0.2))
var acceleration = Vector3(0, 0, 0)
var maxForce = 0.005
var maxEdge = 20

func _ready():
	pass

func _process(_delta):
	self.global_transform.origin += velocity
	velocity += acceleration

func align(boids: Array) -> Vector3:
	var total = 0
	var perception = 5
	var steering = Vector3(0, 0, 0)

	for boid in boids:
		var distance = self.global_transform.origin.distance_to(boid.global_transform.origin)

		if boid != self && distance < perception:
			steering += boid.velocity
			total += 1

	if total > 0:
		steering = steering / total
		steering = steering - self.velocity

		# Doing this because there isn't a Vector3.clamped, unlike Vector2. Don' know why!
		if steering.length() > maxForce:
			steering = steering.normalized() * maxForce

	return steering

func flock(boids: Array):
	var alignment = self.align(boids)

	acceleration = alignment


func edges():
	if self.global_transform.origin.x < -maxEdge:
		self.global_transform.origin.x = maxEdge

	if self.global_transform.origin.x > maxEdge:
		self.global_transform.origin.x = -maxEdge

	if self.global_transform.origin.z < -maxEdge:
		self.global_transform.origin.z = maxEdge

	if self.global_transform.origin.z > maxEdge:
		self.global_transform.origin.z = -maxEdge
