
function textBoxDebugger(str, idx = 0){
	draw_set_colour(c_white);
	var scale_ = 0.3;
	var lineHeight = 5;
	draw_text_ext_transformed(x - 60, y - (60 - idx*lineHeight), str, lineHeight, 180, scale_, scale_, 0);
}

function logBigXValueChange(currentX, newX, moveSpeed) {
	if abs(currentX - newX) > moveSpeed {
		show_debug_message("moved too fast in state: " + state.get_current_state());
	}
}