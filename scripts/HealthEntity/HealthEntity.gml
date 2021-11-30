/// @description Creates properties for an object that has health and can be destroyed/die (Player, Enemy1, WoodBox)
/// @param maxHP(1)
/// @param defense(0)
/// @param knockbackResistance(0)
/// @param invincibleDuration(0)
function initializeHealthEntity(maxHP_ = 1, defense_ = 0, knockbackResistance_ = 0, invincibleDuration_ = 1 ) {
	maxHP =  maxHP_;
	hp = maxHP;
	defense = defense_;
	knockbackResistance = knockbackResistance_;
	invincibleDuration = invincibleDuration_;
	isInvincible = false;
	knockbackVelocity = 0;
};
