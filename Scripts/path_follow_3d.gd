extends PathFollow3D

@export var Speed = 1
@export var Follower:Node3D
@export var minDistance = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):
	var distanceFactor = $PathPoint.global_position.distance_to(Follower.global_position)
	if distanceFactor < minDistance:
		progress_ratio += 0.01*Speed/distanceFactor
