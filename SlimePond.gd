extends Area2D

@onready var Player = get_parent().get_node("Rosa")
var colliding
var healingcounter


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func poolentered(area: Area2D):
	if area.get_parent() is Player:
		colliding = true
		healingcounter = 0
	if area.is_in_group("Hitbox") and area.get_parent().is_in_group("Grounded"):
		area.get_parent().spd *= 0.5

func poolexited(area: Area2D):
	if area.get_parent() is Player:
		colliding = false
	if area.is_in_group("Hitbox") and area.get_parent().is_in_group("Grounded"):
		area.get_parent().spd *= 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if colliding:
		if healingcounter < 60:
			healingcounter += 1
			if healingcounter == 60 and Player.curhp < Player.maxhp:
				Player.curhp += 1
				print("healing")
		else: healingcounter = 0

