; --- move_bullet: advance the player's bullet by its xvel; expire off-screen or on a wall (@done)
move_bullet:
	ld ix, PLAYER_BULLET
	ld a, (ix+ALIEN.x)
	add a, (ix+ALIEN.xvel)
	ld (ix+ALIEN.x), a
	cp $38
	jr c, move_bullet_0
	cp $C4
	jr nc, move_bullet_0
	call alien_hits_wall
	jr c, move_bullet_0
	ret
move_bullet_0:
	ld (ix+ALIEN.state), $00
	ret
