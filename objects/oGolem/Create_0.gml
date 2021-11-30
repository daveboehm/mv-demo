initializeHealthEntity(5, 0, 0, 3);

// initializeMovementEntity(0, 0, 2, 1, 1, 0.5, 0);
initializeMovementEntity(
	0,		// hsp
	0,		// vsp
	0.5,	// moveSpeed
	1,		// gravityModifier
	0,		// collisionBounce
	0.5,	// groundFriction
	0,		// airFriction
);

// @TODO: Move to `initializeAttackEntity` method
canAttack = true;
canMove = true;
damageAmount = 1;
knockbackForce = 5;

state = new SnowState("idle");

state.add("idle", {
	enter: function() {
		image_index = 0;
		sprite_index = sGolemIdle;
		image_speed = 1;
	},
	step: function() {
		// hurtable();
		move();
		applyGravity();
		
		if (withinDistance(oPlayer, 180) && canMove) {
			if (withinDistance(oPlayer, 40)) {
				if canAttack {
					state.change("attack");
				} else {
					move(0);
				}
			} else {
				state.change("move");
			}
		}
	}
});

state.add("move", {
	enter: function() {
		image_index = 0;
		sprite_index = sGolemMove;
		image_speed = 1;
	},
	step: function() {
		applyGravity();
		
		
		if (!withinDistance(oPlayer, 180)) {
			state.change("idle");
		}
		else if (withinDistance(oPlayer, 40)) {
			if canAttack {
				state.change("attack");
			} else {
				state.change("idle");
			}
		} else {
			move(moveSpeed * -sign(x - oPlayer.x));
		}
	}
});

state.add("attack", {
	enter: function() {
		image_index = 0;
		sprite_index = sGolemAttack;
		image_speed = 1;
	},
	step: function() {
		applyGravity();
		
		if isFrame(6) createDamageEntity(sGolemAttack_dmg, damageAmount, knockbackForce, 3, oPlayer);
		
		if (isLastFrame()) {
			canAttack = false;
			alarm[0] = global.ONE_SECOND * 2;
			
			canMove = false;
			alarm[1] = global.ONE_SECOND;
			
			state.change("idle");
		}
	}
});

state.add("taunt", {
	enter: function() {
		image_index = 0;
		sprite_index = sGolemTaunt;
		image_speed = 1;
	},
	step: function() {
		move(0);
		applyGravity();
		if (isLastFrame()) {
			state.change("idle");
		}
	}
});

state.add("hurt", {
	enter: function() {
		image_index = 0;
		sprite_index = sGolemHurt;
		image_speed = 1;
		
	},
	step: function() {
		drawSelfFlash();
		move(knockbackVelocity, -1);
		
		if isLastFrame() {
			isInvincible = true;
			alarm[2] = invincibleDuration;
			var nextState = hp <= 0 ? "die" : "idle";
			state.change(nextState);
		}
	}
});

state.add("die", {
	enter: function() {
		image_index = 0;
		sprite_index = sGolemDie;
		image_speed = 1;
	},
	step: function() {
		// @TODO: apply exp, drop items, etc
		if isLastFrame() instance_destroy();
	}
});