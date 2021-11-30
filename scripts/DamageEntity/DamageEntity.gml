/// @description Creates properties for an object that causes damage to HealthEntities (Bullet, Sword slash, etc)
/// @param sprite
/// @param damageAmount
/// @param knockback
/// @param duration - frames until destroyed
/// @param target
function createDamageEntity(sprite_, dmg_, knockback_, duration_, target_) {
	var dmgEntity_ = instance_create_layer(x, y, "Instances", oDamageEntity);
	dmgEntity_.damageAmount = dmg_;
	dmgEntity_.knockbackForce = knockback_;
	dmgEntity_.image_xscale = facing;
	dmgEntity_.sprite_index = sprite_;
	dmgEntity_.alarm[0] = duration_;
	dmgEntity_.target = target_;
	return dmgEntity_;
};


function applyAttack(dmgEntity) {
	show_debug_message("Attacked");
	var incomingDamage = dmgEntity.damageAmount - defense;
	var incomingKnockback = (dmgEntity.knockbackForce - knockbackResistance);
	knockbackVelocity = sign(x - dmgEntity.x) * incomingKnockback;
	hp -= incomingDamage;
	instance_destroy(dmgEntity.id);
	state.change("hurt");
}
