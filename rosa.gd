extends CharacterBody2D
class_name Player

var maxhp = 25
var curhp = 25
var spd = 200
var direction = "X"

func SetMaxHP(newhp):
	maxhp = newhp

func gethp():
	return curhp

# Controlls the dropping of health when taking damage
func drophp(amount):
	for i in range(amount):
		get_parent().add_child(load("res://health.tscn").instantiate())

# Controls collisions with various objects
func collide(area: Area2D):
	if area.is_in_group("Hitbox"):
		if (area.get_parent().is_in_group("Enemy")):
			#$AnimatedSprite2D.modulate = Color(1, 0, 0)
			var enemyhp = area.get_parent().gethp()
			if (enemyhp < curhp):
				curhp -= enemyhp
				print(curhp)
				drophp(enemyhp)
			else:
				get_tree().reload_current_scene()
		if (area.get_parent() is Health):
			curhp += 1
			print(curhp)
	if area.is_in_group("Explosion"):
		var enemyhp = area.get_parent().gethp()
		#$AnimatedSprite2D.modulate = Color(1, 0, 0)
		if (enemyhp < curhp):
			curhp -= enemyhp
			print(curhp)
			drophp(enemyhp)
		else:
			get_tree().reload_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var input = Vector2()
	if Input.is_key_pressed(KEY_D):
		input.x += 1
	else:
		input.x += 0
	if Input.is_key_pressed(KEY_A):
		input.x -= 1
	else:
		input.x -= 0
	if Input.is_key_pressed(KEY_S):
		input.y += 1
	else:
		input.y += 0
	if Input.is_key_pressed(KEY_W):
		input.y -= 1
	else:
		input.y -= 0
	velocity = input.normalized()*spd
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.x > 0:
		$AnimatedSprite2D.play("move_R")
		direction = "R"
	if velocity.x < 0:
		$AnimatedSprite2D.play("move_L")
		direction = "L"
	if velocity.x == 0:
		if velocity.y > 0:
			if direction == "R":
				$AnimatedSprite2D.play("move_R")
			else: $AnimatedSprite2D.play("move_L")
		if velocity.y < 0:
			if direction == "L":
				$AnimatedSprite2D.play("move_L")
			else: $AnimatedSprite2D.play("move_R")
		if velocity.y == 0:
			$AnimatedSprite2D.play("idle")
