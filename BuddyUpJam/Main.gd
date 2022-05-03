extends Node2D

export(Array, PackedScene) var testScenes
#the current location to place the next scene
var currentLoc = 0
#The previously used index for scenes
var prevIndex
#RandomNumberGenerator for use later
var rng = RandomNumberGenerator.new()
#the width for each scene
export var sceneWidth = 640

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#When called, grab a random scene from the current scene array
#Place it at the currentLoc * scenewidth
#Increment currentLoc, record the index
func addNext(curSceneList):
	var index = rng.randi_range(0, curSceneList.size()-1)
	if index == prevIndex:
		index -= 1
	prevIndex = index
	var platform = testScenes[index].instance()
	self.add_child(platform)
	platform.global_position.x = currentLoc * sceneWidth
	platform.global_position.y = 0
	currentLoc += 1

func deleteLast():
	pass


func _on_SceneSpawner_timeout():
	addNext(testScenes)
