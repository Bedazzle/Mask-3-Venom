; --- update_player: per-frame player update - read keys, set facing/velocity/draw offset, then dispatch the action (@done)
update_player:
	ld hl, PLAYFIELD_MAP-1		;LF0BF
	ld bc, $1800
update_player_0:
	DUP 8
		ld (hl), c
		dec l
	EDUP
	djnz update_player_0

; This entry point is used by go_fall and player_standing (.walk).
update_player_1:
	ld a, (PLAYER_Y_COORD)
	add a, $30
	cp $A0
	jr c, update_player_2

	ld a, $FF
	ld (DROWNING), a
update_player_2:
	ld ix, PLAYER
	ld a, (INPUT_LOCK)
	and a
	jp nz, update_player_6

	ld a, (PLAYER)

	cp $05
	jr z, update_player_4

	cp $06
	jr z, update_player_4

	ld (ix+ALIEN.param2), $00
	ld a, (KEY_FIRE_CURRENT)
	bit 1, a
	jr z, update_player_3

	ld (ix+ALIEN.facing), $80
	ld (ix+ALIEN.param2), $FE
update_player_3:
	bit 0, a
	jr z, update_player_4

	ld (ix+ALIEN.facing), $00
	ld (ix+ALIEN.param2), $02
update_player_4:
	call find_player_cell

	ld (ix+ALIEN.draw_x), $00
	ld a, (PLAYER_X_COORD)

	cp $41
	jr nc, update_player_5

	ld (ix+ALIEN.draw_x), $80
update_player_5:
	cp $B2
	jr c, update_player_6

	ld (ix+ALIEN.draw_x), $9D
update_player_6:
	ld a, (PLAYER)

	cp $01
	jp nz, action_by_accum

	ld iy, player_walk
; This entry point is used by the routine at player_standing.
update_player_7:
	ld a, (KEY_FIRE_CURRENT)
	bit 2, a
	jr z, update_player_8

pressed_down:
	ld hl, (PLAYER_CELL_PTR)
	ld a, (hl)

	cp $14
	jp z, go_transfer_room

	cp $15
	jp z, go_transfer_room

	inc hl
	ld a, (hl)

	cp $14
	jp z, go_transfer_room

	cp $15
	jp z, go_transfer_room

	ld a, (LEVEL_NUMBER)
	and a
	jr nz, update_player_8

	ld a, (ROOM_NUMBER)

	cp $28
	jr nz, update_player_8

	ld hl, (PLAYER_CELL_PTR)
	ld de, $0081
	add hl, de
	ld a, (hl)

	cp $1C
	jr nz, update_player_8

	ld a, (PLAYER_X_COORD)
	sub $40
	rlca
	rlca
	rlca
	and $03
	ld e, a
	ld d, $00
	ld hl, TELEPORT_1
	add hl, de
	ld a, (hl)
	and a
	jr z, update_player_8
	jp start_teleport

update_player_8:
	jp (iy)
