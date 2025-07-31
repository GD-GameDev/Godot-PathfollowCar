extends VehicleBody3D

@export var PathPointer:Node3D
@export var PathPoint:Node3D
@export var MaxSpeed = 200
@export var SteerSpeed = 10

@export var SteerAngle = 0.7

@export var Pfactor :float = 1
@export var Ifactor :float = 1
@export var Dfactor :float = 1



var PreviousAngleError = 0
var AngleIntegral = 0
var PID = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	center_of_mass = $CenterOfMass.position # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if PathPoint != null and PathPointer != null:
		PathPointer.look_at(PathPoint.global_position,Vector3.UP)
		SteeringFunc(delta)
		EngineFunc(delta)
	else:
		print("PIDnassigned PathPoint And PathPointer")

func SteeringFunc(delta):

	var AngleError = global_basis.z.signed_angle_to(-PathPointer.global_basis.z,Vector3.UP)
	AngleIntegral += AngleError*delta
	PreviousAngleError = AngleError
	var AngleChange = (AngleError-PreviousAngleError)/delta
	PID = Pfactor*AngleError + Ifactor*AngleIntegral + Dfactor*AngleChange

	steering = lerp(steering,clamp(PID,-SteerAngle,SteerAngle),SteerSpeed*delta)
	

func EngineFunc(delta):
	var k = global_position.distance_to(PathPoint.global_position)
	engine_force = MaxSpeed*clamp(k-PID,0.5,1)
	
