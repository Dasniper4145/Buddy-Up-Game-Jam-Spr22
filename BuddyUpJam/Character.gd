extends KinematicBody2D

#The velocity variable
export var velocity = Vector2.ZERO
#The max speed reached by character
export var maxSpeed = 1000
#The accelleration variable (Not gravitys acceleration)
export var accel = .25
#The jump speed. Make sure its negative. 
export var jumpSpeed = -750
#The acceleration due to gravity
export var gravity = 2000
#While true, the character can doublejump.
var doubleJump = true
#The absolute lowest the character can go without 'dying'
export var deathFloor = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Linear interpolation to accelerate the speed smoothly.
	velocity.x = lerp(velocity.x, maxSpeed, accel)
	#Checks if the character is colliding on the floor. 
	if is_on_floor():
		#Sets the animation to run
		$AnimatedSprite.animation = 'Run'
		#Makes the doublejump variable true
		doubleJump = true
	else:
		#otherwise, we are jumping
		#Replace with more sophisticated stuff if we have seperate falling animations
		$AnimatedSprite.animation = 'Jump'
	#When the "Accept" key is pressed (Space bar),
	#And the character is either on the floor or has a double jump available
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or doubleJump):
		#Set the y velocity to the jump speed
		velocity.y = jumpSpeed
		#Run the jump function
		jump()
	#add the gravity velocity to the y velocity
	velocity.y += gravity * delta
	#Move and slide per the up vector and the velocity given.
	velocity = move_and_slide(velocity, Vector2.UP)
	if global_position.y > deathFloor:
		death()

#Called when a jump is made
func jump():
	#Get rid of double jump if used. 
	if doubleJump and !is_on_floor():
		doubleJump = false

func death():
	get_tree().reload_current_scene()
