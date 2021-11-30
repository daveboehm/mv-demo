/// @description single player XBox gamepad
function Gamepad() {
	dvc = 0;
	if (gamepad_is_connected(dvc)) {
		
		var deadzone_ = 0.1;
		gamepad_set_axis_deadzone(dvc, deadzone_);
		 
		joystickUp = gamepad_axis_value(dvc, gp_axislv); // || keyboard_check(ord("W"));
		joystickDown = gamepad_axis_value(dvc, gp_axislv); // || keyboard_check(ord("S"));
		joystickLeft = gamepad_axis_value(dvc, gp_axislh) < deadzone_; // || keyboard_check(ord("A"));
		joystickRight = gamepad_axis_value(dvc, gp_axislh) > deadzone_; // || keyboard_check(ord("D"));
	
		dpadUp = gamepad_button_check(dvc, gp_padu); // || keyboard_check(ord("W"));
		dpadDown = gamepad_button_check(dvc, gp_padd); // || keyboard_check(ord("S"));
		dpadLeft = gamepad_button_check(dvc, gp_padl); // || keyboard_check(ord("A"));
		dpadRight = gamepad_button_check(dvc, gp_padr); // || keyboard_check(ord("D"));
		
		// XBox
		btnX = gamepad_button_check(dvc, gp_face3);
		btnY = gamepad_button_check(dvc, gp_face4);
		btnA = gamepad_button_check(dvc, gp_face1);
		btnB = gamepad_button_check(dvc, gp_face2);
		
		// Playstation
		btnSquare = btnX;
		btnTriangle = btnY;
		btnCross = btnA;
		btnCircle = btnB;
	
		btnXpressed = gamepad_button_check_pressed(dvc, gp_face3);
		btnYpressed = gamepad_button_check_pressed(dvc, gp_face4);
		btnApressed = gamepad_button_check_pressed(dvc, gp_face1);
		btnBpressed = gamepad_button_check_pressed(dvc, gp_face2);
	
		btnXreleased = gamepad_button_check_released(dvc, gp_face3);
		btnYreleased = gamepad_button_check_released(dvc, gp_face4);
		btnAreleased = gamepad_button_check_released(dvc, gp_face1);
		btnBreleased = gamepad_button_check_released(dvc, gp_face2);
	
		btnStart = gamepad_button_check_released(dvc, gp_start);
		btnSelect = gamepad_button_check_released(dvc, gp_select);
		btnR1 = gamepad_button_check_released(dvc, gp_shoulderr);
		btnR2 = gamepad_button_check_released(dvc, gp_shoulderrb);
		btnL1 = gamepad_button_check_released(dvc, gp_shoulderl);
		btnL2 = gamepad_button_check_released(dvc, gp_shoulderlb);
		
		// joystickHorizontal = joystickRight - joystickLeft;
		joystickHorizontal = gamepad_axis_value(dvc, gp_axislh);
		joystickVertical = gamepad_axis_value(dvc, gp_axislv); // joystickDown - joystickUp;
		joystickAngle = point_direction(0, 0, sign(joystickHorizontal), sign(joystickVertical)); // 0 45 90 135 180 225 270 315 360
		if (joystickAngle == 360) { joystickAngle = 0; }
		
		dpadHorizontal = dpadRight - dpadLeft;
		dpadVertical = dpadDown - dpadUp;
		dpadAngle =  point_direction(0, 0, dpadHorizontal, dpadVertical); // 0 45 90 135 180 225 270 315 360
		if (dpadAngle == 360) { dpadAngle = 0; }
		
		
	}
}
