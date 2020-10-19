extends Control

class VectorLine:
  var start_position
  var end_position
  var width = 2
  var color = Color(0, 1, 0, 1)

  func _init(_start_position, _end_position, _width, _color):
    start_position = _start_position
    end_position = _end_position
    width = _width
    color = _color

  func draw(control: Control, camera: Camera):
    var start = camera.unproject_position(start_position)
    var end = camera.unproject_position(end_position)

    control.draw_line(start, end, color, width)
    control.draw_triangle(end, start.direction_to(end), width * 5, color)


var vectors = []
onready var camera = get_viewport().get_camera()

func draw_triangle(pos, dir, size, color):
  var a = pos + dir * size
  var b = pos + dir.rotated(2 * PI / 3) * size
  var c = pos + dir.rotated(4 * PI / 3) * size
  var points = PoolVector2Array([a, b, c])

  draw_polygon(points, PoolColorArray([color]))

func _draw():
  for vector in vectors:
    vector.draw(self, camera)

  vectors.clear()

func draw_vector_line(start_position, end_position, width, color):
  var vectorLine = VectorLine.new(start_position, end_position, width, color)
  vectorLine.draw(self, camera)

func add_vector(start_position, end_position, width, color):
  var newVectorLine = VectorLine.new(start_position, end_position, width, color)
  self.vectors.append(newVectorLine)

  self.update()
