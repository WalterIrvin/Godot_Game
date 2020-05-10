extends Spatial
enum _blockTypes{
	air,
	grass
};
var _neighborBlocks = [
	Vector3(1, 0, 0), # left
	Vector3(-1, 0, 0), # right
	Vector3(0, 1, 0), # up
	Vector3(0, -1, 0), # down
	Vector3(0, 0, 1), # forward
	Vector3(0, 0, -1) # behind
];
var _blockArray = [];
var _block = preload("res://assets/instances/Block.tscn");
# Called when the node enters the scene tree for the first time.
func _ready():
	init_chunk();


#func _process(delta):
#	pass

func init_chunk():
	# Initializes a chunk, which is 16x16 by 256
	var offsetVec = Vector3();
	for x in range(16):
		offsetVec.x = x;
		for z in range(16):
			offsetVec.z = z;
			for y in range(1):  # one layer for the time being
				offsetVec.y = y;
				var blockObj = _block.instance();
				blockObj.call_deferred("set_data", _blockTypes.grass,
				 offsetVec);
				add_child(blockObj);
