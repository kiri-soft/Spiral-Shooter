extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MarginContainer2/VBoxContainer/Label2.text = "Score:"+str(Global.score)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
