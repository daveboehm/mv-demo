/// @description foreach([1,2], function(i) { return i + oPlayer.damage });
/// @param array
/// @param callbackFunction
function foreach(array_, callbackFunc_) {
	for (var i = 0; i < array_length(array_); i++) {
		callbackFunc_(array_[i]);
	}
}

/// @description roundTo(5.12789, .01) => 5.13
/// @param value
/// @param increment
function roundTo(val_, incr_) {
	return round(val_/incr_) * incr_;
}

/// @description Check if the current frame of an animation matches the index provided
/// @param frame
function isFrame(frame_) {
	// Ensure this is defined: global.ONE_SECOND = game_get_speed(gamespeed_fps);
	var speed_ = global.ONE_SECOND/sprite_get_speed(sprite_index);
	return (image_index >= frame_+1 - image_speed/frame_) and (image_index < frame_+1);
}

/// @description Returns true if current image_index is on its last animation frame
function isLastFrame() {
	return (image_speed > 0) && (image_index >= image_number-1);
}

/// @description Check if provided frame is within animation range. Inclusive on both ends.
/// @param startingFrame
/// @param endingFrame
function isInFrameRange(start_, end_) {
	return (image_index >= start_) && (image_index <= end_);
}

/// @description changes to the next state on last frame of current animation
/// @param nextState<string>
function chainAnimation(nextState) {
	if (isLastFrame()) {
		state.change(nextState);
	}
}

/// @description Check if `other` is threshold pixels or closer. Inclusive.
/// @param otherObject
/// @param threshold
function withinDistance(otherObject_, threshold_) {
	var distance_ = point_distance(x, y, otherObject_.x, otherObject_.y);
	return distance_ <= threshold_;
}

/// @description value approaches target at `rate` per frame. approach(0, 10, .5) => .5,1,1.5,2...
/// @param currentValue
/// @param targetValue
/// @param rate
function approach(current_, target_, amount_) {
	if (current_ < target_) {
	    return min(current_ + amount_, target_); 
	} else {
	    return max(current_ - amount_, target_);
	}
}

/// @description Random percent chance to return true.
/// @param percent(0-100)
function chance(percent_) {
	return random(1) < percent_;
}

/// @description Return the index of matching value.
/// @param value
/// @param array
function findIndex(val_, array_) {
	for (var i_ = 0; i_ < array_length(val_); i_++) {
		if val_ == array_[i_] {
			return i_;
		}
	}
	return -1;
}

/// @description Plays an animation sprite at the location, destroys self with optional callback
/// @param hPosition
/// @param vPosition
/// @param sprite
/// @param callbackFunc
function animationEffect(o) {
	// @TODO
	// Play sprite_index for it's entire frames length, then remove/callback()
}

/// @description Draw a flash over the current object
/// @param col('white')
/// @param interval('something quick')
/// @param duration
function drawSelfFlash(color_ = c_white, interval_ = 0.3, duration_ = 0.9) {
	if (duration_ % interval_) <= interval_/2 and duration_ > 0 {
		gpu_set_fog(true, color_, 0, 1);
		draw_self();
		gpu_set_fog(false, color_, 0, 1);
	}
}


/// @description Draw an increasingly rapid flash   UNSURE THIS WORKS. ALARM/DURATION IS IFFY
/// @param duration
/// @param col
function imminentFlash(o) {
	var interval_ = ceil(o.duration/global.ONE_SECOND)*8;
	drawSelfFlash(o.col, interval_, o.duration);
}



