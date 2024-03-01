extends Node2D
class_name fireball_indicator

var hp = 0
var canDespawn
var playerInRange

func gethp():
	return hp


func playerEntered(area: Area2D):
	if (area.get_parent() is Player):
		print("entered")
		playerInRange = true

func playerExited(area: Area2D):
	if (area.get_parent() is Player):
		print("exited")
		playerInRange = false

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().getTarget()
	canDespawn = false
	playerInRange = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_parent().getTarget()


func _physics_process(delta):
	if canDespawn:
		hp = 1
		if playerInRange:
			get_parent().get_parent().get_node("Rosa").collide(self.get_node("ExplosionRange"))
		queue_free()



