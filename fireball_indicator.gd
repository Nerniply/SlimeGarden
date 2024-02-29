extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().getTarget()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_parent().getTarget()


func _physics_process(delta):
	pass
