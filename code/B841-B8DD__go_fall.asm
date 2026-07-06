; --- go_fall ---------------------------------------------------
; @done
; Player fall physics (gravity). The Jackrabbit weapon (WEAPON $05)
; diverts to flying instead of falling.
; In: ix = player
go_fall:
	ld iy, (ACTIVE_SLOT)
	ld a, (iy + SLOT.WEAPON)

	cp $05		; Jackrabbit
	jr nz, not_flying

	jp start_fly


.pad:
	ret	; unreachable padding byte


not_flying:
	ld a, (PLAYER_X_DISP)
	and a
	jr z, fall_apply

	bit 7, (ix+ALIEN.draw_x)
	jr nz, .commit

	ld a, (BLAST_ARMED)
	and a
	jr nz, .commit

	ld hl, (PLAYER_CELL_LEAD)
	ld de, $0040

	call is_solid
	jr c, fall_apply

	add hl, de

	call is_solid
	jr c, fall_apply

	add hl, de

	call is_solid
	jr c, fall_apply

.commit:
	call fall_move_x

	jp fall_apply

fall_move_x:
	ld a, (PLAYER_X_COORD)

	cp $3B
	jr nc, .check_right

	call go_left_room
	jr nz, fall_apply

	ld (ix+ALIEN.xvel), $00
	jr fall_apply

.check_right:
	cp $B6
	jr c, .walk

	call go_right_room
	jr nz, fall_apply

	ld (ix+ALIEN.xvel), $00
	jr fall_apply

.walk:
	add a, (ix+ALIEN.xvel)
	ld (PLAYER_X_COORD), a

	ret

fall_apply:
	call check_ground

	and a
	jr nz, .landed

	ld a, (PLAYER_JUMP_IDX)
	add a, (ix+ALIEN.y)
	ld (PLAYER_Y_COORD), a
	ld a, (PLAYER_JUMP_IDX)

	cp $08
	ret z

	ld c, $08
	ld a, (SPRITESET)

	cp $02
	jr nz, .theme2

	ld a, (SLOT.BLINK)
	and $03
	ret nz

.theme2:
	inc (ix+ALIEN.param1)

	ret

.landed:
	ld (ix+ALIEN.state), $01
	ld a, (PLAYER_Y_COORD)
	and $F8
	ld (PLAYER_Y_COORD), a

	jp update_player_1
