extends Node2D
class_name Player

var maxhp = 25
var curhp = 25
var spd = 10

func _physics_process(delta):
	var move = Vector2()
	move.x = spd*(int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A)))
	move.y = spd*(int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W)))
	position += move

func SetMaxHP(newhp):
	maxhp = newhp

func drophp(amount):
	for i in range(amount):
		get_parent().add_child(load("res://health.tscn").instantiate())

func collide(area: Area2D):
	if (area.get_parent() is Enemy):
		var enemyhp = area.get_parent().gethp()
		if (enemyhp < curhp):
			curhp -= enemyhp
			drophp(enemyhp)
		else:
			get_tree().reload_current_scene()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
