extends Sprite2D
var direction = false

func init(d):
	direction = d

func _ready():
	scale = Vector2(1, 1)

func _physics_process(delta):
	if direction:	
		position.x -= 15
		flip_h = true
	else:
		position.x += 15
		flip_h = false

