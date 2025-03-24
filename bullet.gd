extends Area2D

@export var speed: float = 500.0 
@export var lifetime: float = 2.0  
var direction: Vector2 = Vector2.ZERO 

func _ready():
	$Timer.wait_time = lifetime
	$Timer.connect("timeout", self._on_lifetime_end)
	$Timer.start()

func _process(delta):
	shooting(delta)

func shooting(delta: float):
	position += direction * speed * delta

func _on_lifetime_end():
	queue_free()  


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.do_emit = true
		body.queue_free()
		$"enemy dead sfx".play()
		get_parent().get_node("player").score += 1
	if "spiral" in body.name:
		queue_free()
		
