go_left_room:
	ld a, (ROOM_NUMBER)
	and a
	jr z, go_left_room_1

	sub $08					; go left room
	ld (ROOM_NUMBER), a
go_left_room_0:
	ld (ix + PLAYER_X), $B2
	push ix

	call LA89D

	pop ix
	or $FF

	ret

go_left_room_1:
	ld iy, (ROOM_EXITS_ADDR)
	ld a, (iy+$00)

	cp $FF
	ret z

	ld (LEVEL_NUMBER), a
	ld a, $28				; teleports room
	ld (ROOM_NUMBER), a
	jr go_left_room_0

go_right_room:
	ld a, (ROOM_NUMBER)

	cp $28
	jr z, go_right_room_1

	add a, $08				; go right room
	ld (ROOM_NUMBER), a

go_right_room_0:
	ld (ix + PLAYER_X), $3E
	push ix

	call LA89D

	pop ix
	or $FF

	ret

go_right_room_1:
	ld iy, (ROOM_EXITS_ADDR)
	ld a, (iy+$01)

	cp $FF
	ret z

	ld (LEVEL_NUMBER), a
	xor a

	ld (ROOM_NUMBER), a
	jr go_right_room_0


LB6B3:
	ld ix, (ROOM_EXITS_ADDR)
	ld a, (ix+$02)

	cp $FF
	ret z

	ld (LEVEL_NUMBER), a
	ld a, (ix+$05)
	ld l, a
	and $1F
	add a, a
	add a, a
	add a, $40
	ld (PLAYER_X_COORD), a
	ld a, l
	and $E0
	rrca
	rrca

	ld (ROOM_NUMBER), a

	jp LA89D
