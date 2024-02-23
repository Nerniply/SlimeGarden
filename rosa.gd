extends Node2D

var health = 30
var spd = 4

func _physics_process(delta):
	var move = Vector2()
	move.x = spd*(int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A)))
	move.y = spd*(int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W)))
	position += move


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
