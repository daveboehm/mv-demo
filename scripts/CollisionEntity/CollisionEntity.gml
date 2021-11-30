/// @description Creates properties for a new collision object
/// @param type("solid, platform, door, destructable, collapsible, moving')
function initializeCollisionEntity(o) {
	type = o.type;
	if (type == "destructable") {
		initializeHealthEntity({maxHP: 1, defense: 0, });
	}
}

