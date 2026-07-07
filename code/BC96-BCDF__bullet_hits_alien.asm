; --- bullet_hits_alien: bounding-box test of the player's shot vs this alien; sets ALIEN.hit (@done)
bullet_hits_alien:
	ld a, (PLAYER_BULLET)
	and a
	jr z, bullet_hits_alien_0
	ld a, (ix+ALIEN.state)
	and $BF
	jr z, bullet_hits_alien_0
	cp $03
	jr z, bullet_hits_alien_0
	ld a, (BULLET_X)
	add a, $06
	sub (ix+ALIEN.x)
	ld l, a
	ld a, (ix+ALIEN.width)
	add a, a
	add a, a
	add a, $04
	cp l
	jr c, bullet_hits_alien_0
	ld a, (BULLET_Y)
	add a, $0C
	sub (ix+ALIEN.y)
	ld l, a
	ld a, (ix+ALIEN.height)
	add a, a
	add a, a
	add a, a
	add a, $08
	cp l
	jr c, bullet_hits_alien_0
	ld a, (ix+ALIEN.state)
	cp $0A
	jr z, bullet_hits_alien_0
	ld a, (BULLET_HIT)
	ld (ix+ALIEN.hit), a
	and a
	ret
bullet_hits_alien_0:
	or $FF
	ret
