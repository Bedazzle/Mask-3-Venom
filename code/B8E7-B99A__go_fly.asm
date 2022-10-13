go_fly:
	ld iy, (ACTIVE_SLOT)
	ld a, (iy+$01)

	cp $05 
	jr nz, LB8E7_4

	inc (ix+$11)
	ld a, (ix+$11)

	cp $05
	jr nz, LB8E7_1

	ld (ix+$11), $00
	ld c, $01
	ld a, (LA194)

	cp $02
	jr nz, LB8E7_0

	ld c, $15
LB8E7_0:
	ld a, c

	call LB210

LB8E7_1:
	ld a, (KEY_FIRE_CURRENT)
	bit 3, a
	jr z, LB8E7_2

	ld hl, (LB3E8)

	call LB993
	call c, LBA93

	jr c, LB8E7_5

	inc l

	call LB993
	call c, LBA93

	jr c, LB8E7_5

	ld a, (ix+$04)

	cp $05
	jr c, LB8E7_5

	sub $04
	ld (ix+$04), a
	jr LB8E7_5

LB8E7_2:
	ld c, $02
	bit 2, a
	jr z, LB8E7_3

	ld c, $04
LB8E7_3:
	call LB706

	and a
	jr nz, LB8E7_4

	ld a, (ix+$04)
	add a, c
	ld (ix+$04), a
	jr LB8E7_5

LB8E7_4:
	ld (ix+$00), $01
	ret

LB8E7_5:
	bit 7, (ix+$13)
	jr nz, LB8E7_6

	ld hl, (LB3E6)
	ld de, $0020

	call LB993
	ret c

	add hl, de

	call LB993
	ret c

	add hl, de

	call LB993
	ret c

	add hl, de

	call LB993
	ret c

LB8E7_6:
	ld a, (PLAYER_X_COORD)

	cp $3B
	jr nc, LB8E7_7

	bit 7, (ix+$12)
	jp nz, go_left_room

LB8E7_7:
	cp $B6
	jr c, LB8E7_8

	bit 7, (ix+$12)
	jp z, go_right_room

LB8E7_8:
	add a, (ix+$12)
	ld (PLAYER_X_COORD), a

	ret


LB993:
	push de
	ld d, $EF
	ld e, (hl)
	ld a, (de)
	add a, a
	pop de

	ret
