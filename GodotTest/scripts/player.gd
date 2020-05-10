extends KinematicBody

var gravity = Vector3.DOWN;
var speed = 50;
var velocity = Vector3();

func _ready():
	pass

func _physics_process(delta):
	velocity += gravity * delta;
	process_input(delta);
	velocity = move_and_slide(velocity, Vector3.UP);

func process_input(delta):
	if Input.is_action_pressed("move_forward"):
		velocity.z -= speed * delta;
	elif Input.is_action_pressed("move_backward"):
		velocity.z += speed * delta;
	elif Input.is_action_pressed("move_left"):
		velocity.x -= speed * delta;
	elif Input.is_action_pressed("move_right"):
		velocity.x += speed * delta;
