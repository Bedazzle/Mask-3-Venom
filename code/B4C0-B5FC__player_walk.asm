; --- player_walk: ground movement - down=crouch/stairs, up=jump, left/right=walk with wall collision (@done)
player_walk:
	call check_ground
	and a
	jp z, start_fall
	bit 7, (ix+ALIEN.facing)
	jr nz, player_walk_0
	ld hl, (PLAYER_CELL_PTR)
	ld de, $0082
	add hl, de
	call is_solid
	jr c, player_walk_2
	jr player_walk_1
player_walk_0:
	ld hl, (PLAYER_CELL_PTR)
	ld de, $0081
	add hl, de
	call is_solid
	jr c, player_walk_2
player_walk_1:
	ld de, $0020
	add hl, de
	call is_solid
	jr nc, player_walk_2
	ld a, (ix+ALIEN.param2)
	ld (ix+ALIEN.xvel), a
	ld (ix+ALIEN.timer), $02
	ld a, $03
	ld (ix+ALIEN.state), a
	jp action_by_accum

player_walk_2:
	ld a, (KEY_FIRE_CURRENT)
	and $0F
	jr nz, player_walk_3
	ld a, $08
	ld (PLAYER), a
	jp action_by_accum

player_walk_3:
	ld c, a
	bit 2, c
	jr z, player_walk_4
	ld a, (PLAYER_Y_COORD)
	add a, $08
	ld (PLAYER_Y_COORD), a
	ld a, $04
	ld (PLAYER), a
	jp action_by_accum

player_walk_4:
	bit 3, c
	jr z, player_walk_7
	ld iy, (ACTIVE_SLOT)
	ld a, (iy+SLOT.WEAPON)
	cp $05
	jp z, start_fly
	bit 7, (ix+ALIEN.draw_x)
	jr nz, player_walk_6
	ld a, (BLAST_ARMED)
	and a
	jr nz, player_walk_5
	ld hl, (PLAYER_CELL_LEAD)
	call is_solid
	ret c
player_walk_5:
	ld hl, (PLAYER_CELL_PTR)
	ld de, $FFE0		; -32
	add hl, de
	call is_solid
	ret c
	inc l
	call is_solid
	ret c
player_walk_6:
	ld (ix+ALIEN.param1), $F7
	ld a, (ix+ALIEN.param2)
	ld (ix+ALIEN.xvel), a
	ld a, $05
	ld (PLAYER), a
	jp action_by_accum

player_walk_7:
	bit 1, c
	jr z, player_walk_11
	bit 7, (ix+ALIEN.draw_x)
	jr nz, player_walk_10
	ld a, (BLAST_ARMED)
	and a
	jr z, player_walk_8
	ld hl, (PLAYER_CELL_LEAD)
	ld de, $0040
	add hl, de
	call is_solid
	jr c, player_walk_10
	ld de, $0020
	jr player_walk_9
player_walk_8:
	ld hl, (PLAYER_CELL_LEAD)
	call is_solid
	ret c
	ld de, $0020
	add hl, de
	call is_solid
	ret c
	add hl, de
	call is_solid
	ret c
player_walk_9:
	add hl, de
	call is_solid
	jp c, player_recoil

player_walk_10:
	ld a, (PLAYER_X_COORD)
	cp $3B
	jp c, go_left_room

	sub $02
	ld (PLAYER_X_COORD), a

	ret

player_walk_11:
	bit 0, c
	ret z
	bit 7, (ix+ALIEN.draw_x)
	jr nz, player_walk_14
	ld a, (BLAST_ARMED)
	and a
	jr z, player_walk_12
	ld hl, (PLAYER_CELL_LEAD)
	ld de, $0040
	add hl, de
	call is_solid
	jr c, player_walk_14
	ld de, $0020
	jr player_walk_13
player_walk_12:
	ld hl, (PLAYER_CELL_LEAD)
	call is_solid
	ld de, $0020
	add hl, de
	call is_solid
	ret c
	add hl, de
	call is_solid
	ret c
	add hl, de
player_walk_13:
	call is_solid
	jp c, player_recoil
player_walk_14:
	ld a, (PLAYER_X_COORD)
	cp $B6
	jp nc, go_right_room

	add a, $02
	ld (PLAYER_X_COORD), a

	ret
