/// @description Creates properties for an object that moves
/// @param hsp
/// @param vsp
/// @param moveSpeed
/// @param gravityModifier
/// @param collisionBounce
/// @param groundFriction
/// @param airFriction
function initializeMovementEntity(
	hsp_ = 0,
	vsp_ = 0,
	moveSpeed_ = 1,
	gravityModifier_ = 1,  // 0: no gravity, 1: normal, 2+: extra gravity
	collisionBounce_ = 0,
	groundFriction_ = 1,
	airFriction_ = 0
) {
	hsp = hsp_;
	vsp = vsp_;
	moveSpeed = moveSpeed_;
	gravityModifier = gravityModifier_;
	collisionBounce = collisionBounce_;
	groundFriction = groundFriction_;
	airFriction = airFriction_;
	facing = 1;
	grav = 0.6;
	maxGravity = global.MAX_GRAVITY;
	jumpHeight = 0;
};

/// @description Returns boolean value if groundObj is 1px below entity
function onGround() {
	return place_meeting(x, y + 1, oCollisionEntity) == true;
}

/// Wrapper method for controlling player move func
function playerMove() {
	move(sign(joystickHorizontal) * moveSpeed);
}

/// @param horizontalValue
/// @param forcedBackwards // @TODO: betterize this
function move(hsp_ = 0, forcedBackwards = 1) {
	hsp = hsp_;
	
	moveAndCollide();
	
	if (hsp != 0) {
		facing = sign(hsp) * forcedBackwards;
		idleLeft = facing < 0;
	}
}

function moveAndCollide() {
	if place_meeting(x + hsp, y, oCollisionEntity) {
		while !place_meeting(x + sign(hsp), y, oCollisionEntity) {
			x += sign(hsp);
		}
		hsp = 0;
	}
	if place_meeting(x, y + vsp, oCollisionEntity) {
		while !place_meeting(x, y + sign(vsp), oCollisionEntity) {
			y += sign(vsp);
		}
		vsp = 0;
	}
	
	x += hsp;
	y += vsp;
	
}

function aim() {
	aimDirection = DPadAngle;
	
	// No DPad input but facing left
	if (idleLeft > 0) {
		aimDirection = 180;
	}
}

/// @description Things that don't float
function applyGravity() {
	if (!onGround()) {
		vsp += grav * gravityModifier;		
		vsp = min(vsp, maxGravity);
	}
}
