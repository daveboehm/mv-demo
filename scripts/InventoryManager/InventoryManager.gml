/// @description Creates empty inventory of n size
/// @param size
function initializeInventory(o) {
	global.inventory = [];

	var i_ = 0;
	repeat (o.size) {
		global.inventory[i_] = noone;
		i_++;
	}
}

//////////// @TODO BELOW

/// @description Adds an item to the inventory
/// @param item
function inventory_add_item(argument0) {
	var _item = singleton(argument0);

	var _item_index = array_find_index(_item, global.inventory);
	if _item_index == -1 {
		var _array_size = array_length_1d(global.inventory);
		for (var _i=0; _i<_array_size; _i++) {
			if global.inventory[_i] == noone {
				global.inventory[_i] = _item;
				return true;
			}
		
		}
	} else {
		return true;
	}

	return false;


}

///@arg x
///@arg y
function inventory_draw(argument0, argument1) {
	if not o_game.paused_ exit;
	var _x = argument0;
	var _y = argument1;
	var _array_size = array_length_1d(global.inventory);

	for (var _i=0; _i<_array_size; _i++) {
		var _box_x = _x+_i*32;
		var _box_y = _y;
		draw_sprite(s_inventory_box, 0, _box_x, _box_y);
	
		var _item = global.inventory[_i];
		if instance_exists(_item) {
			draw_sprite(_item.sprite_, 0, _box_x+16, _box_y+16);
		}
	
		if _i == item_index_ {
			draw_sprite(s_pause_cursor, image_index/8, _box_x, _box_y);
			if instance_exists(_item) {
				draw_text(_x+4, _y+36, _item.description_);
				var _description_height = string_height(_item.description_);
				draw_text(_x+4, _y+48+_description_height, "Stamina cost: "+string(_item.cost_));
			}
		}
	}

	draw_sprite(s_inventory_box, 0, 4, 4);
	draw_sprite(s_inventory_box, 0, 36, 4);
	if instance_exists(global.item[0]) {
		draw_sprite(global.item[0].sprite_, 0, 20, 20);
	}
	if instance_exists(global.item[1]) {
		draw_sprite(global.item[1].sprite_, 0, 52, 20);
	}

}

///@arg input
///@arg item
function inventory_use_item(argument0, argument1) {
	var _input = argument0;
	var _item = argument1;
	if _input {
		if instance_exists(_item) {
			state_ = _item.action_;
			image_index = 0;
		}
	}


}

