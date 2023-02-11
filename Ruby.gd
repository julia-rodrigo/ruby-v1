extends KinematicBody
onready var save_file = SaveFile.g_data

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

func _ready():
	get_node("IdelFront").show();
	pass
	
#	get_node("IdelFrontLeft").hide();
func hideNode(name):
	get_node(name).hide();	

func showNode(name):
	get_node(name).show();	
	
func viewingSprite(hideSprite, showSprite) -> String:
	hideNode(hideSprite);
	showNode(showSprite);
	return showSprite;
	

func _physics_process(delta):
		
		
		if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
			velocity.x = 0;
			idelName = viewingSprite(idelName, RunToIdel[idelName])
		elif Input.is_action_pressed("ui_right"):
			velocity.x = -SPEED;
			idelName = viewingSprite(idelName, "RunFrontRight");
		elif Input.is_action_pressed("ui_left"):
			velocity.x = SPEED;
			idelName = viewingSprite(idelName, "RunFrontLeft");
		else: 
			
			velocity.x = lerp(velocity.x, 0, 1);
			idelName = viewingSprite(idelName, RunToIdel[idelName]) # only add transition change here
			
			

		if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
			velocity.z = 0;
		elif Input.is_action_pressed("ui_up"):
			velocity.z = SPEED;
			idelName = viewingSprite(idelName, "RunBack");			
		elif Input.is_action_pressed("ui_down"):
			velocity.z = -SPEED;
			idelName = viewingSprite(idelName, "RunFront");			
		else: 
			velocity.z = lerp(velocity.z, 0, 1);
			
		if not is_on_floor():
			velocity.y = -gravity;
			

		move_and_slide(velocity) # move the character
		save_file.velocity = velocity
#		$AnimationPlayer.set("parameters/Idle/blend_position", velocity);
		



