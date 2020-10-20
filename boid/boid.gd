extends KinematicBody

onready var debug_overlay = get_node("/root/DebugOverlay")

var velocity = Vector3(rand_range(-0.15, 0.15), rand_range(-0.15, 0.15), rand_range(-0.15, 0.15))
var acceleration = Vector3(0, 0, 0)
var maxForce = 0.002
var maxSeperationForce = 0.003
var maxEdgeX = 30
var maxEdgeZ = 30
var maxEdgeY = 10
var maxSpeed = 0.15

func _ready():
	pass

func _process(_delta):
	self.global_transform.origin += velocity
	velocity += acceleration

	velocity.y = 0

func seperation(boids: Array) -> Vector3:
	var total = 0
	var perception = 6
	var steering = Vector3(0, 0, 0)

	for boid in boids:
		var distance = self.global_transform.origin.distance_to(boid.global_transform.origin)

		if boid != self && distance < perception:
			var difference = self.global_transform.origin - boid.global_transform.origin
			difference = difference / distance
			steering += difference
			total += 1

	if total > 0:
		steering = steering / total
		steering = steering.normalized() * maxSpeed
		steering = steering - self.velocity

		# Doing this because there isn't a Vector3.clamped, unlike Vector2. Don' know why!
		if steering.length() > maxSeperationForce:
			steering = steering.normalized() * maxSeperationForce

	return steering

func cohesion(boids: Array) -> Vector3:
	var total = 0
	var perception = 5
	var steering = Vector3(0, 0, 0)

	for boid in boids:
		var distance = self.global_transform.origin.distance_to(boid.global_transform.origin)

		if boid != self && distance < perception:
			steering += boid.global_transform.origin
			total += 1

	if total > 0:
		steering = steering / total
		steering = steering - self.global_transform.origin
		debug_overlay.draw.add_vector(
			self.global_transform.origin,
			self.global_transform.origin + steering,
			1,
			Color(1, 0, 0, 1)
		)
		steering = steering.normalized() * maxSpeed
		steering = steering - self.velocity


		# Doing this because there isn't a Vector3.clamped, unlike Vector2. Don' know why!
		if steering.length() > maxForce:
			steering = steering.normalized() * maxForce

	return steering

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

		# Not sure if to keep this. Basically set mag of vector to always go at maximum speed
		steering = steering.normalized() * maxSpeed

		steering = steering - self.velocity

		# Doing this because there isn't a Vector3.clamped, unlike Vector2. Don' know why!
		if steering.length() > maxForce:
			steering = steering.normalized() * maxForce

	return steering

func flock(boids: Array):
	var alignment = self.align(boids)
	var cohesion = self.cohesion(boids)
	var seperation = self.seperation(boids)

	acceleration = Vector3(0, 0, 0)

	acceleration = acceleration + seperation
	acceleration = acceleration + alignment
	acceleration = acceleration + cohesion

	debug_overlay.draw.draw_str(self.global_transform.origin, str(acceleration))

	debug_overlay.draw.add_vector(
		self.global_transform.origin,
		self.global_transform.origin + (velocity * 20),
		1,
		Color(0, 1, 0, 1)
	)

func edges():
	if self.global_transform.origin.x < -maxEdgeX:
		self.global_transform.origin.x = maxEdgeX

	if self.global_transform.origin.x > maxEdgeX:
		self.global_transform.origin.x = -maxEdgeX

	if self.global_transform.origin.z < -maxEdgeZ:
		self.global_transform.origin.z = maxEdgeZ

	if self.global_transform.origin.z > maxEdgeZ:
		self.global_transform.origin.z = -maxEdgeZ

	if self.global_transform.origin.y < -maxEdgeY:
		self.global_transform.origin.y = maxEdgeY

	if self.global_transform.origin.y > maxEdgeY:
		self.global_transform.origin.y = -maxEdgeY
