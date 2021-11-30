function initializeBaseAbilities(){
	jumpHeight = -10;
	idleLeft = 0;
	facing = 1;
	aimDirection = 0;
	maxGravity = global.MAX_GRAVITY;
	slideHsp = 5;
	rollHsp = 6;
	damageAmount = 1;
	knockbackForce = 1;
	crouchHsp = 1
	resetPlayerAttackSequence();
}

function initializeAcquiredAbilities() {
	canDoubleJump = false;
	canAirDash = false;
	canAirAttack = false;
}
