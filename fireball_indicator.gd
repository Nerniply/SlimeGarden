extends Node2D
class_name fireball_indicator

var hp
var canDespawn
var explosion = preload("res://explosion.tscn").instantiate()

func gethp():
	return hp


# Deals damage to the player if the player is in the explosion radius 
func explode(area: Area2D):
	if area.get_parent() == self.get_parent().get_node("Fireball"):
		print("explosion")
		explosion.position = self.position
		explosion.size = 2.5
		get_parent().add_child(explosion)

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().getTarget()
	hp = 0
	canDespawn = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_parent().getTarget()


func _physics_process(delta):
	if canDespawn:
		queue_free()



