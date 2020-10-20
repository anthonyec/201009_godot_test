extends Node

func _ready():
	pass

func _process(_delta):
	var boids = self.get_children()

	for boid in boids:
		boid.flock(boids)
		boid.edges()
