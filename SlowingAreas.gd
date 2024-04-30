extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.is_in_group("Hitbox") and area.get_parent().is_in_group("Grounded"):
		area.get_parent().spd /= 2


func _on_area_exited(area):
	if area.is_in_group("Hitbox") and area.get_parent().is_in_group("Grounded"):
		area.get_parent().spd *= 2
