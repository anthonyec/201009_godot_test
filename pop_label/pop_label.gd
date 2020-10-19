extends Node2D

export (Vector2) var final_scale = Vector2(2, 2)
export (float) var float_distance = 100
export (float) var duration = 1
export (String) var label_text = "Label Text"

var transparentColor = Color(1, 1, 1, 0)

func _ready():
	$Label.text = label_text
	pop()
	
func pop():
	$Tween.interpolate_property(
		self,
		"scale",
		scale,
		final_scale,
		duration,
		Tween.TRANS_BACK,
		Tween.EASE_IN_OUT
	)

	$Tween.start()
	
	yield($Tween, "tween_completed")
	
	print("HELLO")
	
	$Tween.interpolate_property(
		self,
		"position",
		position,
		position + Vector2(0, -float_distance),
		duration,
		Tween.TRANS_BACK,
		Tween.EASE_IN
	)
	
	$Tween.interpolate_property(
		self,
		"modulate",
		modulate,
		transparentColor,
		duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	
	yield($Tween, "tween_completed")
	
	print("Done")
	
	queue_free()

