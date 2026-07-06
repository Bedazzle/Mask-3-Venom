; --- move_harrier (alien state, vector 8) --------------------
; @done
; Harrier: sweep in from a room-dependent x while homing
; vertically on the player; falls through to become_explosion.
; In: ix = alien
move_harrier:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .score

	ld hl, (HARRIER_SWEEP)
	dec hl
	ld (HARRIER_SWEEP), hl
	bit $07, h
	jr nz, .explode

	ex de, hl
	ld a, (ROOM_NUMBER)
	ld l, a
	ld h, $00
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, hl	; x8
	add hl, hl	; x16
	ex de, hl
	sbc hl, de
	ld de, $40
	add hl, de
	ld a, h
	and a
	jr z, .sound

	ld a, $FF
	ld (RESET_VOLCANO_SND), a
	ld l, $00
	jr .set_x


.sound:
	ld a, $0F

	call play_sfx

.set_x:
	ld (ix+ALIEN.x), l
	ld a, (BLAST_ARMED)
	and a
	jr z, .home_y

	ld a, $10
	ld (WEAPON_AUTOFIRE), a

.home_y:
	ld a, (PLAYER_Y_COORD)

	cp (ix+ALIEN.y)
	jr z, .set_y

	ld a, (ix+ALIEN.y)
	jr nc, .down

	dec a
	jr .set_y


.down:
	inc a

.set_y:
	ld (ix+ALIEN.y), a

	call alien_hits_player
	ret nz

	call decrease_energy

.score:
	call award_alien_score

.explode:
	ld a, $FF
	ld (RESET_VOLCANO_SND), a

	jp become_explosion
