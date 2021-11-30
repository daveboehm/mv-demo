NORMAL_SPEED = 3;
SLOW_SPEED = 1.5;
FAST_SPEED = 8;

initializeHealthEntity( 
	100, // maxHP
	0,   // defense
	0,	 // knockbackResistance
	3	 // invincibleDuration
);

initializeMovementEntity(
	0,		// hsp
	0,		// vsp
	NORMAL_SPEED,		// moveSpeed
	1,		// gravityModifier
	0,		// collisionBounce
	0.5,	// groundFriction
	0,		// airFriction
);

initializeBaseAbilities();

initializeAcquiredAbilities();

state = new SnowState("idle");

state.add("idle", {
		enter: function() {
			image_index = 0;
			sprite_index = sPlayerIdle;
			image_speed = 1;
		},
		step: function() {
			applyGravity();
			playerMove();
			
			if (vsp > 0 || !onGround()) {
				state.change("fall");
			} 
			if (hsp != 0) {
				state.change("run");
			}
			if (btnBpressed) {
				state.change("roll");
			}
			if (btnApressed) {
				state.change("jump");
			}
			if (btnXpressed) {
				state.change("attack");
			}
			if (joystickDown) {
				state.change("crouch");
			}
		}
	}
);

state.add("fall", {
	enter: function() {
		image_index = 0;
		sprite_index = sPlayerFall;
		image_speed = 1;
	},
	step: function() {
		applyGravity();
		playerMove();
		
		if (onGround()) {
			state.change("idle");
		}
		
		if (canDoubleJump) {}
		if (canAirDash) {}
		if (canAirAttack) {}
	}
});

state.add("run", {
	enter: function() {
		image_index = 0;
		sprite_index = sPlayerRun;
		image_speed = 1;
	},
	step: function() {
		applyGravity();
		playerMove();
		
		if (hsp == 0) {
			state.change("idle");
		}
		
		if (btnBpressed) {
			state.change("roll");
		}
		
		if (joystickDown) {
			state.change("crouch");
		}
		if (btnApressed) {
			state.change("jump");
		}
		if (btnXpressed) {
			state.change("attack");
		}
	},
	leave: function() {
		show_debug_message("left state: " + string(state.get_current_state()) + "x: " + string(x));
		hsp = 0;
		moveSpeed = NORMAL_SPEED;
	}
});

state.add("crouch", {
	enter: function() {
		image_index = 0;
		sprite_index = sPlayerCrouchIdle;
		image_speed = 1;
	},
	step: function() {
		applyGravity();
		playerMove();
		
		if (hsp != 0) {
			state.change("crouchMove");
		}
		
		if (btnBpressed) {
			state.change("roll");
		}
		
		if (!joystickDown) { 
			state.change("idle");	
		}
		
		if (btnApressed) {
			state.change("slide");
		}
	}
});

state.add("crouchMove", {
	enter: function() {
		image_index = 0;
		sprite_index = sPlayerCrouchMove;
		image_speed = 1;
		moveSpeed = crouchHsp;
	},
	step: function() {
		applyGravity();
		playerMove();
		
		if (btnBpressed) {
			state.change("roll");
		}
		if (hsp == 0) {
			state.change("crouch");
		}
		if (btnApressed) {
			state.change("slide");
		}
	},
	leave: function() {
		moveSpeed = NORMAL_SPEED;
	}
});

state.add("jump", {
	enter: function() {
		image_index = 0;
		sprite_index = sPlayerJump;
		image_speed = 0;
		vsp = jumpHeight;
	},
	step: function() {
		applyGravity();
		playerMove();
		
		if (btnAreleased) { 
			vsp = 0;
		}
		
		if (vsp >= 0) {
			state.change("fall");
		}
	}
});

state.add("attack", {
	enter: function() {
		image_index = 0;
		sprite_index = sPlayerAttack;
		image_speed = 1;
		resetPlayerAttackSequence();
	},
	step: function() {
		applyGravity();
		
		if isFrame(1) createDamageEntity(sPlayerAttack_dmg, damageAmount, knockbackForce, 3, oEnemyEntity);
		
		if (btnBpressed) {
			state.change("roll");
		}
		if (btnXpressed) {
			queueCombo = true;
		}
		if (isLastFrame()) {
			var nextState = queueCombo ? "attackCombo" : "idle";
			state.change(nextState);
		}
	}
});

state.add("attackCombo", {
	enter: function() {
		image_index = 0;
		sprite_index = sPlayerAttackCombo;
		image_speed = 1;
	},
	step: function() {
		applyGravity();
		
		if isFrame(2) createDamageEntity(sPlayerAttackCombo_dmg, damageAmount, knockbackForce, 3, oEnemyEntity);
		
		if (btnBpressed) {
			state.change("roll");
		}
		if (btnXpressed) {
			queueFinisher = true;
		}
		if (isLastFrame()) {
			var nextState = queueFinisher ? "attackFinisher" : "idle";
			state.change(nextState);
		}
	}
});

state.add("attackFinisher", {
	enter: function() {
		image_index = 0;
		sprite_index = sPlayerAttackFinisher;
		image_speed = 1;
	},
	step: function() {
		applyGravity();
		
		if isFrame(2) createDamageEntity(sPlayerAttackFinisher_dmg, damageAmount, knockbackForce, 4, oEnemyEntity);
		
		if (btnBpressed) {
			state.change("roll");
		}
		
		if (isLastFrame()) {
			state.change("idle");
		}
	}
});

state.add("slide", {
	enter: function() {
		image_index = 0;
		sprite_index = sPlayerSlide;
		image_speed = 1;
		moveSpeed = slideHsp;
	},
	step: function() {
		applyGravity();
		move(slideHsp*facing);
		
		if (isLastFrame() || !onGround()) {
			state.change("idle");
		}
	},
	leave: function() {
		hsp = 0;
		moveSpeed = NORMAL_SPEED;
	}
});

state.add("roll", {
	enter: function() {
		image_index = 0;
		sprite_index = sPlayerRoll;
		image_speed = 1;
		resetPlayerAttackSequence();
		moveSpeed = rollHsp;
		// invincible = true;
	},
	step: function() {
		applyGravity();
		move(rollHsp*facing);
		
		if (isLastFrame() || !onGround()) {
			state.change("idle");
		}
	},
	leave: function() {
		hsp = 0;
		moveSpeed = NORMAL_SPEED;
	}
});
