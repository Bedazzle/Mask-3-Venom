go_jump:
	ld a, (LA194)
	cp $02
	jr nz, LB7B5_0

	ld a, (SLOT.BLINK)
	and $03
	jr z, LB7B5_1

LB7B5_0:
	ld a, (LA450)
	inc a
	ld (LA450), a

	cp $01
	jr nz, LB7B5_1

	ld (ix+$00), $01
	jp LB6E8_0

LB7B5_1:
	ld hl, (LB3E8)

	call LB993
	jp c, LB7B5_6

	inc l

	call LB993
	jp c, LB7B5_6

	ld a, (LA450)
	add a, (ix+$04)
	ld (PLAYER_Y_COORD), a
	ld a, (LA45A)
	and a
	ret z

	bit 7, (ix+$13)
	jr nz, LB7B5_2

	ld a, (LB3EA)
	and a
	jr nz, LB7B5_2

	ld hl, (LB3E6)
	ld de, $0040

	call LB993
	ret c

	add hl, de

	call LB993
	ret c

	srl d
	rr e
	add hl, de

	call LB993
	ret c

LB7B5_2:
	ld a, (PLAYER_X_COORD)

	cp $3B
	jr nc, LB7B5_3

	call go_left_room
	jr z, LB7B5_5

	ret

LB7B5_3:
	cp $B6
	jr c, LB7B5_4

	call go_right_room
	jr z, LB7B5_5

	ret

LB7B5_4:
	add a, (ix+$1B)
	ld (PLAYER_X_COORD), a

	ret
LB7B5_5:
	ld (ix+$00), $01

	ret

LB7B5_6:
	ld (ix+$00), $01

	jp LBA93
