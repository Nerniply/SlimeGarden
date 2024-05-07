extends VSplitContainer

@onready var HealthBarHeart = preload("res://heart_gui.tscn")

var resetHearts = false
signal heartreset
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setmaxhearts(max: int):
	resetHearts = true
	resetHearts = false
	if max <= 10:
		for i in range(max):
			var heart = HealthBarHeart.instantiate()
			$Row1.add_child(heart)
	else:
		for i in range(10):
			var heart = HealthBarHeart.instantiate()
			$Row1.add_child(heart)
		for j in range(max-10):
			var heart = HealthBarHeart.instantiate()
			$Row2.add_child(heart)

func updateCurHP(curhp: int):
	var heartlist = $Row1.get_children() + $Row2.get_children()
	for i in range(curhp):
		heartlist[i].update(true)
	for i in range(curhp, heartlist.size()):
		heartlist[i].update(false)

func updateMaxHP(maxhp: int):
	var heartlist = $Row1.get_children() + $Row2.get_children()
	for i in range(maxhp, heartlist.size()):
		heartlist[i].erase(true)

func addArmor(armor: int):
	var heartlist = $Row1.get_children() + $Row2.get_children()
	for i in range(heartlist.size()-armor):
		heartlist[i].armor(false)
	for i in range(heartlist.size()-armor,heartlist.size()):
		heartlist[i].armor(true)
