extends StaticBody


var _id = 0;
var _offset = Vector3();  # position in the chunk
var _size = Vector3();
enum _directions{
	top, bottom, left, right, forward, backward
};
var _directionTranslation = {
	_directions.forward: Vector3(0, 0, 1),
	_directions.backward: Vector3(0, 0, -1),
	_directions.right: Vector3(-1, 0, 0),
	_directions.left: Vector3(1, 0, 0),
	_directions.top: Vector3(0, 1, 0),
	_directions.bottom: Vector3(0, -1, 0)
};
onready var _blockFace = preload("res://assets/instances/BlockFace.tscn");
onready var _collider = self.get_node("CollisionShape");
onready var _leftFace = null;  # +X
onready var _rightFace = null;  # -X
onready var _frontFace = null;  # +Z
onready var _backFace = null;  # -Z
onready var _topFace = null;  # +Y
onready var _bottomFace = null;  # -Y


func set_data(id, offset):
	_id = id;
	_offset = offset;
	_size = _collider.scale;
	translate_object_local(_offset * (_size * 2));


func check_empty_horizontal(direction, blockArray, spriteFace, e):
	var other = blockArray[direction];
	if other._offset.y == _offset.y:
		if other._id != 0:  # If block is not air, delete face
			if spriteFace != null:
				spriteFace.queue_free();
		else:
			# generate face if missing
			generate_face(e);


func check_empty_vertical(direction, blockArray, spriteFace, e):
	var other = blockArray[direction];
	if other._offset.y != _offset.y:
		if other._id != 0:  # If block is not air, delete face
			if spriteFace != null:
				spriteFace.queue_free();
		else:
			# generate face if missing
			generate_face(e);


func generate_face(direction):
	if direction == _directions.forward and _frontFace == null:
		_frontFace = _blockFace.instance();
		_frontFace.axis = 2;
		add_child(_frontFace);
		_frontFace.translate_object_local(_directionTranslation[direction]);
		
	elif direction == _directions.backward and _backFace == null:
		_backFace = _blockFace.instance();
		_backFace.axis = 2;
		add_child(_backFace);
		_backFace.translate_object_local(_directionTranslation[direction]);

	elif direction == _directions.left and _leftFace == null:
		_leftFace = _blockFace.instance();
		_leftFace.axis = 0;
		add_child(_leftFace);
		_leftFace.translate_object_local(_directionTranslation[direction]);

	elif direction == _directions.right and _rightFace == null:
		_rightFace = _blockFace.instance();
		_rightFace.axis = 0;
		add_child(_rightFace);
		_rightFace.translate_object_local(_directionTranslation[direction]);

	elif direction == _directions.top and _topFace == null:
		_topFace = _blockFace.instance();
		_topFace.axis = 1;
		add_child(_topFace);
		_topFace.translate_object_local(_directionTranslation[direction]);

	elif direction == _directions.bottom and _bottomFace == null:
		_bottomFace = _blockFace.instance();
		_bottomFace.axis = 1;
		add_child(_bottomFace);
		_bottomFace.translate_object_local(_directionTranslation[direction]);


func check_neighbors(idx, blockArray):
	# Checks through the block array, looking for neighbors from its idx.
	var max_len = len(blockArray) - 1;
	var front = idx + 16;
	var back = idx - 16
	var left = idx + 1;
	var right = idx - 1;
	var top = idx + 256;
	var bottom = idx - 256;
	# Check each side of the cube in the array, provided there is one.
	if front <= max_len:
		check_empty_horizontal(front, blockArray, _frontFace, _directions.forward);
	else:
		generate_face(_directions.forward);
		
	if back >= 0:
		check_empty_horizontal(back, blockArray, _backFace, _directions.backward);
	else:
		generate_face(_directions.backward);
		
	if left <= max_len and idx % 16 != 15:
		check_empty_horizontal(left, blockArray, _leftFace, _directions.left);
	else:
		generate_face(_directions.left);
		
	if right >= 0 and idx % 16 != 0:
		check_empty_horizontal(right, blockArray, _rightFace, _directions.right);
	else:
		generate_face(_directions.right);
		
	if top <= max_len:
		check_empty_vertical(top, blockArray, _topFace, _directions.top);
	else:
		generate_face(_directions.top);
		
	if bottom >= 0:
		check_empty_vertical(bottom, blockArray, _bottomFace, _directions.bottom);
	else:
		generate_face(_directions.bottom);
