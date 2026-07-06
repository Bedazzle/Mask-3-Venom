; --- change_room -----------------------------------------------
; @done
; Room-transition cluster: go_left_room / go_right_room step to the
; adjacent room; go_transfer_room takes a transfer/down exit.
go_left_room:
	ld a, (ROOM_NUMBER)
	and a
	jr z, go_left_room_1

	sub $08					; go left room
	ld (ROOM_NUMBER), a
go_left_room_0:
	ld (ix + PLAYER_X), $B2
	push ix

	call draw_room

	pop ix
	or $FF

	ret

go_left_room_1:
	ld iy, (ROOM_EXITS_ADDR)
	ld a, (iy+ROOM_EXITS.LEFT)

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

	call draw_room

	pop ix
	or $FF

	ret

go_right_room_1:
	ld iy, (ROOM_EXITS_ADDR)
	ld a, (iy+ROOM_EXITS.RIGHT)

	cp $FF
	ret z

	ld (LEVEL_NUMBER), a
	xor a

	ld (ROOM_NUMBER), a
	jr go_right_room_0


go_transfer_room:
	ld ix, (ROOM_EXITS_ADDR)
	ld a, (ix+ROOM_EXITS.TRANSFER)

	cp $FF
	ret z

	ld (LEVEL_NUMBER), a
	ld a, (ix+ROOM_EXITS.TRANSFER_DEST)
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

	jp draw_room
