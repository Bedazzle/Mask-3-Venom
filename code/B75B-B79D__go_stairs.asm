go_upstairs:
	ld a, (PLAYER_X_COORD)
	add a, (ix+$1B)
	ld (PLAYER_X_COORD), a

	ld a, (PLAYER_Y_COORD)
	sub $04
	ld (PLAYER_Y_COORD), a

	dec (ix+$10)
	ret nz

	ld (ix+$00), $01

	ret


go_downstairs:
	dec (ix+$10)
	jp m, LB775_0

	ld a, (PLAYER_X_COORD)
	add a, (ix+$1B)

	cp $B6
	jp nc, go_right_room

	cp $3B
	jp c, go_left_room

	ld (PLAYER_X_COORD), a
	ld a, (PLAYER_Y_COORD)
	add a, $04
	ld (PLAYER_Y_COORD), a

	ret

LB775_0:
	ld (ix+$00), $01

	jp LB3EB
