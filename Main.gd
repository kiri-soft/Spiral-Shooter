extends Node2D

var can_open_shop = true
@onready var score_container: MarginContainer = $"CanvasLayer/Score Container"
@onready var skill_container: Control = $"CanvasLayer/Skill Container"
@export var enemy_scene :PackedScene
@onready var score: Label = $"CanvasLayer/Score Container/HBoxContainer/score"
@onready var player: CharacterBody2D = $player

func _ready() -> void:
	skill_container.hide()
	$spawntimer.start()

func _process(delta: float) -> void:
	if is_instance_valid(player):
		score.text = str(player.score)
	
	if Input.is_action_pressed("shop") and can_open_shop:
		skill_container.show()
		can_open_shop = false
	else:
		can_open_shop = true
		skill_container.hide()
		
func _spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.player = player
	enemy.position = Vector2(randf_range(-1280,1280),randf_range(-720,720))
	$enemies.add_child(enemy)
	
func _on_spawntimer_timeout() -> void:
	_spawn_enemy()
	$spawntimer.start()
