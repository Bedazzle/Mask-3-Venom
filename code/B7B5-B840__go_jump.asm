; --- go_jump ---------------------------------------------------
; @done
; Player jump physics: rise along the jump arc while the jump key
; is held, then transition to falling.
; In: ix = player
go_jump:
	ld a, (SPRITESET)
	cp $02
	jr nz, .tick

	ld a, (SLOT.BLINK)
	and $03
	jr z, .rise

.tick:
	ld a, (PLAYER_JUMP_IDX)
	inc a
	ld (PLAYER_JUMP_IDX), a

	cp $01
	jr nz, .rise

	ld (ix+ALIEN.state), $01
	jp start_fall_0

.rise:
	ld hl, (PLAYER_CELL_PTR)

	call is_solid
	jp c, .blocked

	inc l

	call is_solid
	jp c, .blocked

	ld a, (PLAYER_JUMP_IDX)
	add a, (ix+ALIEN.y)
	ld (PLAYER_Y_COORD), a
	ld a, (PLAYER_X_DISP)
	and a
	ret z

	bit 7, (ix+ALIEN.draw_x)
	jr nz, .move_x

	ld a, (BLAST_ARMED)
	and a
	jr nz, .move_x

	ld hl, (PLAYER_CELL_LEAD)
	ld de, $0040

	call is_solid
	ret c

	add hl, de

	call is_solid
	ret c

	srl d
	rr e
	add hl, de

	call is_solid
	ret c

.move_x:
	ld a, (PLAYER_X_COORD)

	cp $3B
	jr nc, .check_right

	call go_left_room
	jr z, .land

	ret

.check_right:
	cp $B6
	jr c, .walk

	call go_right_room
	jr z, .land

	ret

.walk:
	add a, (ix+ALIEN.xvel)
	ld (PLAYER_X_COORD), a

	ret
.land:
	ld (ix+ALIEN.state), $01

	ret

.blocked:
	ld (ix+ALIEN.state), $01

	jp apply_hazard_damage
