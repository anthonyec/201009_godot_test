extends CanvasLayer

# onready var draw = $DebugDraw3D
var draw

func _ready():
	print("Debug overlay ready!")

	# TODO: Figure out a way to not hardcode this path
	draw = get_node("/root/Spatial/DebugOverlay/DebugDraw3D")

	# print(get_node("/root/Spatial/DebugOverlay/DebugDraw3D"))

func _input(event):
	if event.is_action_pressed("toggle_debug"):
		print("Toggle debug!")

# func _ready():
# 	if not InputMap.has_action("toggle_debug"):
# 		InputMap.add_action("toggle_debug")
# 		var ev = InputEventKey.new()
# 		ev.scancode = KEY_BACKSLASH
# 		InputMap.action_add_event("toggle_debug", ev)

# func _input(event):
# 	if event.is_action_pressed("toggle_debug"):
# 		print("Toggle debug!")

# 		for n in get_children():
# 			n.visible = not n.visible

# func add_vector(object, property, scale, width, color):
# 	print("ADD_VECTOR")
