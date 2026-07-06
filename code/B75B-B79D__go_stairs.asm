; --- go_stairs -------------------------------------------------
; @done
; Move the player up/down a staircase: step x by the input xvel
; and adjust y (go_upstairs / go_downstairs entries).
; In: ix = player
go_upstairs:
	ld a, (PLAYER_X_COORD)
	add a, (ix+ALIEN.xvel)
	ld (PLAYER_X_COORD), a

	ld a, (PLAYER_Y_COORD)
	sub $04
	ld (PLAYER_Y_COORD), a

	dec (ix+ALIEN.timer)
	ret nz

	ld (ix+ALIEN.state), $01

	ret


go_downstairs:
	dec (ix+ALIEN.timer)
	jp m, .edge

	ld a, (PLAYER_X_COORD)
	add a, (ix+ALIEN.xvel)

	cp $B6
	jp nc, go_right_room

	cp $3B
	jp c, go_left_room

	ld (PLAYER_X_COORD), a
	ld a, (PLAYER_Y_COORD)
	add a, $04
	ld (PLAYER_Y_COORD), a

	ret

.edge:
	ld (ix+ALIEN.state), $01

	jp update_player
