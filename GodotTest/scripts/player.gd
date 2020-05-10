extends KinematicBody

var gravity = Vector3.DOWN * 12;
var speed = 50;
var dirVec = get_global_transform().basis;
var forward = -dirVec.z;
var left = -dirVec.x;
var velocity = Vector3();
var jump_force = 500;
var jumped = false;
var friction = 0.05;

func _ready():
	pass

func _physics_process(delta):
	dirVec = get_global_transform().basis;
	forward = -dirVec.z;
	left = -dirVec.x;
	velocity += gravity * delta;
	process_input(delta);
	velocity = move_and_slide(velocity, Vector3.UP);
	velocity.x *= 1.0 - friction;
	velocity.z *= 1.0 - friction;
	if abs(velocity.y) <= 5:
		jumped = false;


func process_input(delta):
	if Input.is_action_pressed("move_forward"):
		velocity += speed * delta * forward;
	elif Input.is_action_pressed("move_backward"):
		velocity -= speed * delta * forward;
	elif Input.is_action_pressed("move_left"):
		velocity += speed * delta * left;
	elif Input.is_action_pressed("move_right"):
		velocity += speed * delta * (-left);
	elif Input.is_action_pressed("quit_game"):
		get_tree().quit();
	if Input.is_action_just_pressed("jump") and not jumped:
		velocity.y += jump_force * delta;
		jumped = true;
