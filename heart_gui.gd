extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_parent().get_parent().resetHearts:
		queue_free()

func update(hashealth: bool):
	if hashealth: $BaseHeart.frame = 0
	else: $BaseHeart.frame = 1

func erase(erased: bool):
	if erased: self.hide()

func armor(isarmored: bool):
	if isarmored: $ArmorHeart.show()
	else: $ArmorHeart.hide()
