extends CanvasLayer

# onready var draw = $DebugDraw3D
var draw

func _ready():
	# TODO: Figure out a way to not hardcode this path
	draw = get_node("/root/Spatial/DebugOverlay/DebugDraw3D")

func _input(event):
	if event.is_action_pressed("toggle_debug"):
		print("Toggle debug!")

		for n in draw.get_children():
			n.visible = not n.visible
