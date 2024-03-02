extends Node2D
class_name fireball_indicator

var hp
var canDespawn
var playerInRange

func gethp():
	return hp

func playerEntered(area: Area2D):
	if (area.get_parent() is Player):
		playerInRange = true

func playerExited(area: Area2D):
	if (area.get_parent() is Player):
		playerInRange = false

# Deals damage to the player if the player is in the explosion radius 
func explode(area: Area2D):
	if area.get_parent() == self.get_parent().get_node("Fireball"):
		print("explosion")
		if playerInRange:
			hp = 1
			get_parent().get_parent().get_node("Rosa").collide(self.get_node("ExplosionRange"))

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().getTarget()
	hp = 0
	canDespawn = false
	playerInRange = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_parent().getTarget()


func _physics_process(delta):
	if canDespawn:
		queue_free()



