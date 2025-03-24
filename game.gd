extends Node2D

@export var a: float = 10  # Initial radius
@export var b: float = 0.2  # Growth rate
@export var max_theta: float = 10 * PI  # Maximum spiral angle
@export var resolution: int = 200  # Number of points
@export var segment_width: float = 5  # Collision shape width
@export var rotation_speed: float = 2.0  # Speed of rotation (in seconds per full turn)

var line: Line2D
var static_body: StaticBody2D
var tween: Tween

func _ready():
	create_spiral()
	start_rotation_animation()

func create_spiral():
	var points = []
	
	for i in range(resolution):
		var theta = i * max_theta / resolution
		var r = a * exp(b * theta)
		var x = r * cos(theta)
		var y = r * sin(theta)
		points.append(Vector2(x, y))
	
	# Draw the spiral using Line2D
	line = Line2D.new()
	line.width = 2
	line.default_color = Color(1, 1, 1)
	line.points = points
	add_child(line)
	
	# Add collisions
	create_collision_segments(points)

func create_collision_segments(points: Array):
	static_body = StaticBody2D.new()
	add_child(static_body)
	
	for i in range(points.size() - 1):
		var start = points[i]
		var end = points[i + 1]
		
		var segment = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		shape.size = Vector2(10, segment_width)  # Segment size
		
		segment.shape = shape
		segment.position = (start + end) / 2
		segment.rotation = (end - start).angle()
		
		static_body.add_child(segment)
