extends Control

onready var label = $Label
onready var tween = $Tween

var duration = 0.5
var text = { chars = 0 }
var chars = 0

var currentLineIndex = 0
var lines = [
  "It is an auto-mobile. We don’t make those much anymore, not really efficient as transport goes.",
  "and they are the symbol of not-so-great things...",
  "It can be a weapon",
  "It has been used as a weapon… in the past…",
  "one has to use it carefully, meaningfully and respectfull",
  "Anyway I think some nerds in a nearby territory still produce a handful, out of sheer passion.",
  "But this one is unique. This one is a souvenir."
]

func steppy(_object, key, _elapsed, value):
  if key != ":chars":
    return

  var charCount = round(value)
  var line = lines[currentLineIndex].substr(0, charCount)

  $Label.text= line

func _ready():
  label.text = lines[0]

func _input(event):
  if event.is_action_pressed("ui_up"):
    tickerPrevLine()

  if event.is_action_pressed("ui_down"):
    tickerNextLine()


func showPrevLine():
  var prevIndex = clamp(currentLineIndex - 1, 0, lines.size() - 1)
  currentLineIndex = prevIndex;
  label.text = lines[prevIndex]

func showNextLine():
  var nextIndex = clamp(currentLineIndex + 1, 0, lines.size() - 1)
  currentLineIndex = nextIndex;
  label.text = lines[nextIndex]

func tickerLine():
  tween.connect("tween_step", self, "steppy")

  tween.interpolate_property(
    self,
    "chars",
    0,
    lines[currentLineIndex].length(),
    lines[currentLineIndex].length() * (0.03),
    Tween.TRANS_LINEAR,
    Tween.TRANS_LINEAR
  )

  tween.start()

func tickerPrevLine():
  showPrevLine()
  tickerLine()

func tickerNextLine():
  tween.interpolate_property(
    label,
    "modulate",
    Color(1, 1, 1, 1),
    Color(1, 1, 1, 0),
    duration,
    Tween.EASE_IN_OUT,
    Tween.EASE_IN_OUT
  )

  tween.start()

  yield($Tween, "tween_completed")

  showNextLine()
  tickerLine()

  yield($Tween, "tween_started")

  label.modulate = Color(1, 1, 1, 1)

func animateNextLine():
  tween.interpolate_property(
    label,
    "rect_position",
    label.rect_position,
    label.rect_position - Vector2(0, 20),
    duration,
    Tween.TRANS_BACK,
    Tween.EASE_IN_OUT
  )

  tween.interpolate_property(
    label,
    "modulate",
    Color(1, 1, 1, 1),
    Color(1, 1, 1, 0),
    duration,
    Tween.EASE_IN_OUT,
    Tween.EASE_IN_OUT
  )

  tween.start()

  yield($Tween, "tween_completed")

  showNextLine()

  tween.interpolate_property(
    label,
    "rect_position",
    label.rect_position + Vector2(0, 40),
    label.rect_position + Vector2(0, 20),
    duration,
    Tween.TRANS_BACK,
    Tween.EASE_IN_OUT
  )

  tween.interpolate_property(
    label,
    "modulate",
    Color(1, 1, 1, 0),
    Color(1, 1, 1, 1),
    duration,
    Tween.EASE_IN_OUT,
    Tween.EASE_IN_OUT
  )

  tween.start()
