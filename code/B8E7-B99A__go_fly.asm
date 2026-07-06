; --- go_fly ----------------------------------------------------
; @done
; Player fly state (Jackrabbit weapon): drift under thrust while
; consuming ammo, colliding with solid tiles (is_solid).
; In: ix = player
go_fly:
	ld iy, (ACTIVE_SLOT)
	ld a, (iy+SLOT.WEAPON)

	cp $05 
	jr nz, .idle

	inc (ix+ALIEN.param1)
	ld a, (ix+ALIEN.param1)

	cp $05
	jr nz, .rise

	ld (ix+ALIEN.param1), $00
	ld c, $01
	ld a, (SPRITESET)

	cp $02
	jr nz, .use_ammo

	ld c, $15
.use_ammo:
	ld a, c

	call consume_ammo

.rise:
	ld a, (KEY_FIRE_CURRENT)
	bit 3, a
	jr z, .settle

	ld hl, (PLAYER_CELL_PTR)

	call is_solid
	call c, apply_hazard_damage

	jr c, .move_x

	inc l

	call is_solid
	call c, apply_hazard_damage

	jr c, .move_x

	ld a, (ix+ALIEN.y)

	cp $05
	jr c, .move_x

	sub $04
	ld (ix+ALIEN.y), a
	jr .move_x

.settle:
	ld c, $02
	bit 2, a
	jr z, .ground

	ld c, $04
.ground:
	call check_ground

	and a
	jr nz, .idle

	ld a, (ix+ALIEN.y)
	add a, c
	ld (ix+ALIEN.y), a
	jr .move_x

.idle:
	ld (ix+ALIEN.state), $01
	ret

.move_x:
	bit 7, (ix+ALIEN.draw_x)
	jr nz, .check_right

	ld hl, (PLAYER_CELL_LEAD)
	ld de, $0020

	call is_solid
	ret c

	add hl, de

	call is_solid
	ret c

	add hl, de

	call is_solid
	ret c

	add hl, de

	call is_solid
	ret c

.check_right:
	ld a, (PLAYER_X_COORD)

	cp $3B
	jr nc, .walk

	bit 7, (ix+ALIEN.param2)
	jp nz, go_left_room

.walk:
	cp $B6
	jr c, .land

	bit 7, (ix+ALIEN.param2)
	jp z, go_right_room

.land:
	add a, (ix+ALIEN.param2)
	ld (PLAYER_X_COORD), a

	ret


is_solid:
	push de
	ld d, $EF
	ld e, (hl)
	ld a, (de)
	add a, a
	pop de

	ret
