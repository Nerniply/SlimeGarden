extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$CenterContainer/AnimatedSprite2D.play("default")


func _on_start_pressed():
	get_tree().change_scene_to_file("res://intro_scene.tscn")

func _on_quit_pressed():
	get_tree().quit()

