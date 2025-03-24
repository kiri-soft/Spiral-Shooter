extends CharacterBody2D

@export var player :CharacterBody2D
var speed = 120
func _ready() -> void:
	$Timer.start()

func _physics_process(delta: float) -> void:

	
	rotate(0.05)
	if is_instance_valid(player):
		var player_position = player.global_position
		# Move towards the player
		var direction = (player.position - position).normalized()
		velocity = direction * speed
	move_and_slide()
	

func _on_timer_timeout() -> void:
	queue_free()
	
