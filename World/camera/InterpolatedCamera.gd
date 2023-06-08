extends InterpolatedCamera
# https://godotengine.org/qa/19177/define-the-limits-of-a-3d-camera#:~:text=0%20votes%20In%20Godot%2C%20it%20seems%20that%20only,and%20does%20not%20stop%20following%20the%20Player%20permanently.

#onready var camera_area_size = $"../CameraArea".get_aabb().size

# Max and Min in the x axis
onready var xMax = get_node("../CameraLimits/xmax").translation.x
onready var zMax = get_node("../CameraLimits/zmax").translation.z
# Max and Min in the y axis
onready var xMin = $"../CameraLimits/xmin".translation.x
onready var zMin =  $"../CameraLimits/zmin".translation.z
# Smooth Camera Trigger and SmoothSpeed value
export var Smooth = false
export var SmoothSpeed = 0.125

# get the camera movement limits that the player can see


func _ready():
	set_process(true)
	pass
#
func _process(_delta):

	var camera_interpolated = get_node(".")
#
	var Clampx = clamp(camera_interpolated.get_translation().x, xMin, xMax)
	var Clampy = camera_interpolated.get_translation().y
	var Clampz = clamp(camera_interpolated.get_translation().z, zMin, zMax)
#
	var All = Vector3(Clampx, Clampy, Clampz)
	
	
	if Smooth == false:
		get_node(".").set_translation(All)
	if Smooth == true:
		var Lerp = camera_interpolated.get_translation().linear_interpolate(All, SmoothSpeed)
		get_node(".").set_translation(Lerp)
