go_fall:
	ld iy, (ACTIVE_SLOT)
	ld a, (iy + SLOT.WEAPON)

	cp $05		; Jackrabbit
	jr nz, not_flying

	jp LB8DE


LB84F:
	defb $C9	; ??? optimize ???


not_flying:
	ld a, (LA45A)
	and a
	jr z, LB87F_2

	bit 7, (ix+$13)
	jr nz, LB850_0

	ld a, (LB3EA)
	and a
	jr nz, LB850_0

	ld hl, (LB3E6)
	ld de, $0040

	call LB993
	jr c, LB87F_2

	add hl, de

	call LB993
	jr c, LB87F_2

	add hl, de

	call LB993
	jr c, LB87F_2

LB850_0:
	call LB87F

	jp LB87F_2

LB87F:
	ld a, (PLAYER_X_COORD)

	cp $3B
	jr nc, LB87F_0

	call go_left_room
	jr nz, LB87F_2

	ld (ix+$1B), $00
	jr LB87F_2

LB87F_0:
	cp $B6
	jr c, LB87F_1

	call go_right_room
	jr nz, LB87F_2

	ld (ix+$1B), $00
	jr LB87F_2

LB87F_1:
	add a, (ix+$1B)
	ld (PLAYER_X_COORD), a

	ret

LB87F_2:
	call LB706

	and a
	jr nz, LB87F_4

	ld a, (LA450)
	add a, (ix+$04)
	ld (PLAYER_Y_COORD), a
	ld a, (LA450)

	cp $08
	ret z

	ld c, $08
	ld a, (LA194)

	cp $02
	jr nz, LB87F_3

	ld a, (SLOT.BLINK)
	and $03
	ret nz

LB87F_3:
	inc (ix+$11)

	ret

LB87F_4:
	ld (ix+$00), $01
	ld a, (PLAYER_Y_COORD)
	and $F8
	ld (PLAYER_Y_COORD), a

	jp LB3EB_1
