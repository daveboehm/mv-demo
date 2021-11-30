/// @description Create a camera on the target: target
function initializeCamera(o) {
	target = o.target;
	width = camera_get_view_width(view_camera[0]);
	height = camera_get_view_height(view_camera[0]);
	scale = view_wport[0] / width;
	cameraScaleIncrement = 1/scale;
	cameraFollowSpeed = 0.1;
}

/// @description Camera follow. Requires `initializeCamera`.
function cameraFollow() {
	if not instance_exists(target) exit;
	x = lerp(x, target.x, 0.1);
	y = lerp(y, target.y-8, 0.1);
	x = roundTo(x, 1/scale);
	y = roundTo(y, 1/scale);
	camera_set_view_pos(view_camera[0], x-width/2, y-height/2);
}


