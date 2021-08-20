extends Spatial
var follow:Vector3
var rota :=0.0

func start(pos):
	follow = pos
	global_transform.origin = pos
	rota=$pivot.rotation.y

func _physics_process(delta: float) -> void:
	rota += (Input.get_action_strength("cam_left")- Input.get_action_strength("cam_right"))*0.1
	var dir = Vector3(
		Input.get_action_strength("left") - Input.get_action_strength("right"),
		0.0,
		Input.get_action_strength("up") - Input.get_action_strength("down")).normalized()
		
	$pivot.rotation.y = lerp_angle($pivot.rotation.y, rota, delta*10)
	follow += (dir * 0.5).rotated(Vector3.UP, $pivot.rotation.y)
	global_transform.origin = global_transform.origin.linear_interpolate(follow,delta*10)

