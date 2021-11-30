function Keyboard(){
	dpadUp = keyboard_check(vk_up);
	dpadDown = keyboard_check(vk_down);
	dpadLeft = keyboard_check(vk_left);
	dpadRight = keyboard_check(vk_right);
		
	btnX = keyboard_check(ord("D"));
	btnY =  keyboard_check(ord("S"));
	btnA = keyboard_check(vk_space);
	btnB = keyboard_check(vk_shift);
	
	btnXpressed = keyboard_check_pressed(ord("D"));
	btnYpressed =  keyboard_check_pressed(ord("S"));
	btnApressed = keyboard_check_pressed(vk_space);
	btnBpressed = keyboard_check_pressed(vk_shift);
	
	btnXreleased = keyboard_check_released(ord("D"));
	btnYreleased =  keyboard_check_released(ord("S"));
	btnAreleased = keyboard_check_released(vk_space);
	btnBreleased = keyboard_check_released(vk_shift);
	
	dpadHorizontal = dpadRight - dpadLeft;
	dpadVertical = dpadDown - dpadUp;
	dpadAngle =  point_direction(0, 0, dpadHorizontal, dpadVertical); // 0 45 90 135 180 225 270 315 360
	if (dpadAngle == 360) { dpadAngle = 0; }
	
	joystickHorizontal = dpadHorizontal;
	joystickVertical = dpadVertical;
	joystickAngle = dpadAngle;
}
