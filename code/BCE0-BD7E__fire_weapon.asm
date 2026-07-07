; --- fire_weapon: on a fresh fire press, consume ammo and launch the player's bullet (PLAYER_BULLET) (@done)
fire_weapon:
	ld a, (INPUT_LOCK)
	and a
	ret nz
	ld a, (PLAYER)
	cp $0A
	jp z, weapon_release
	ld ix, (ACTIVE_SLOT)
	ld a, (ix+SLOT.WEAPON)
	and a
	ret z
	cp $05
	jp c, use_weapon

	ld a, (KEY_FIRE_CURRENT)
	bit 4, a
	ret z

	ld a, (KEY_FIRE_PREVIOUS)
	bit 4, a
	ret nz

	ld a, (PLAYER_BULLET)
	and a
	ret nz
	ld c, $01
	ld a, (ix+SLOT.WEAPON)
	cp $06
	jr nz, fire_weapon_0
	ld c, $08
fire_weapon_0:
	ld a, c
	call consume_ammo
	jr nc, fire_weapon_1
	ret
fire_weapon_1:
	ld a, (ix+SLOT.WEAPON)
	sub $05
	call play_sfx
	ld iy, PLAYER_BULLET
	ld a, (PLAYER_Y_COORD)
	add a, $05
	ld (BULLET_Y), a
	ld a, (PLAYER_FACING)
	add a, a
	ld a, (PLAYER_X_COORD)
	jr c, fire_weapon_2
	ld e, $06
	ld (iy+ALIEN.facing), $00
	add a, $04
	jr fire_weapon_3
fire_weapon_2:
	ld e, $FA
	ld (iy+ALIEN.facing), $FF
fire_weapon_3:
	add a, $02
	ld (BULLET_X), a
	ld (iy+ALIEN.xvel), e
	ld (iy+ALIEN.state), $01
	ld a, (ix+SLOT.WEAPON)
	sub $05
	ld (iy+ALIEN.anim), a
	ld (iy+ALIEN.base_lo), $E0
	ld (iy+ALIEN.base_hi), $D6
	ld a, (ix+SLOT.POWER)
	ld (iy+ALIEN.hp), a
	ld a, (ix+SLOT.WEAPON)
	cp $06
	jr z, fire_weapon_4
	xor a
	ld (iy+ALIEN.hit), a
	ret
fire_weapon_4:
	or $FF
	ld (iy+ALIEN.hit), a
	ret
