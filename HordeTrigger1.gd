extends Area2D

var triggered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func playercollide(area: Area2D):
	if (area.get_parent() is Player):
		triggered = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
