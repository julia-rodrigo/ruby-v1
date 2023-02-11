extends KinematicBody

var velocity = Vector3(0, 0, 0);
var gravity = 5;

const SPEED = 2;
var idelName = "IdelFront"
var moving = false
var RunToIdel = {
	"RunFrontRight": "IdelFrontRight",
	"RunFrontLeft": "IdelFrontLeft",
	"IdelFrontLeft": "IdelFrontLeft",
	"IdelFrontRight": "IdelFrontRight",	
	"IdelBack": "IdelBack",
	"IdelFront": "IdelFront",	
	"RunFront": "IdelFront",
	"RunBack": "IdelBack"	
}

var can_interact = false

func _on_Enter(body):
	if body.name == "Ruby":
		print("enter interact")
		can_interact = true	
	pass
	
func _on_Exit(body):
	if body.name == "Ruby":
		print("exit interact")
		can_interact = false	
		
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y = -gravity;
	
