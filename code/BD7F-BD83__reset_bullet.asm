; --- reset_bullet: deactivate the player's bullet (PLAYER_BULLET state = 0) (@done)
reset_bullet:
	xor a
	ld (PLAYER_BULLET), a
	ret
