extends CharacterBody2D

@export var max_speed: float = 200.0 
@export var acceleration: float = 10.0  
@export var friction: float = 1.0 
@export var bullet_scene: PackedScene
@onready var can_shoot: bool
@export var score:int = 0

func _ready() -> void:
	can_shoot = true

func _physics_process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	look_at(get_global_mouse_position())
	
#	shooting mechanic here
	if Input.is_action_pressed("action") and can_shoot:
		
		shoot_bullet()
	
	
	if input_direction != Vector2.ZERO:
		velocity = velocity.lerp(input_direction * max_speed, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if "spiral_body" in body.name:
		Global.score = score
		get_tree().change_scene_to_file("res://game_over.tscn")
	
	if body.is_in_group("enemy"):
		Global.score = score
		get_tree().change_scene_to_file("res://game_over.tscn")

func shoot_bullet():
	can_shoot = false 
	$Timer.start() 
	$gunsfx.play()
	var bullet = bullet_scene.instantiate()
	bullet.position = $Marker2D.global_position
	
	# Calculate direction toward the mouse
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - bullet.position).normalized()
	bullet.direction = direction # Pass direction to the bullet
	bullet.rotation = direction.angle()  # Rotate the bullet to face the mouse

	get_parent().add_child(bullet)

func _on_timer_timeout():
	can_shoot = true  # Allow shooting again
