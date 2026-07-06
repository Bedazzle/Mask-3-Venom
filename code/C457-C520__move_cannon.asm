; --- move_cannon (alien state, vector 4) ---------------------
; @done
; Cannon emplacement: charge (anim to 3), bob vertically, and
; fire a cannonball (state 5) into a neighbouring record. Writes
; CANNON_KILL into its map cell when destroyed. Spans 2-3 records.
; In: ix = alien
move_cannon:
	ld a, (ix+ALIEN.hp)
	and a
	jp z, .destroyed

	ld a, (ix+ALIEN.anim)

	cp $03
	jr z, .charged

	ld a, (FRAME_PARITY)
	rrca
	ret c

	inc (ix+ALIEN.anim)

	ret
	
.charged:
	inc (ix+ALIEN.yvel)
	bit 4, (ix+ALIEN.yvel)
	jr z, .move_up

	inc (ix+ALIEN.y)
	jr .drawn

.move_up:
	dec (ix+ALIEN.y)
.drawn:
	call cannon_map_cell

	ld (hl), $00
	ld de, $0020
	add hl, de
	ld a, (THEME_PARAM)
	ld (hl), a

	call generate_random

	and $53
	jr z, .fire

	call alien_hits_player
	ret nz

	call decrease_energy

	jp .destroyed

.fire:
	ld b, (ix+ALIEN.y)
	ld c, (ix+ALIEN.x)
	ld de, ALIEN_LEN
	ld a, (ix+ALIEN_LEN+ALIEN.state)

	cp $40
	jr z, .into_next

	ld a, (ix+2*ALIEN_LEN+ALIEN.state)
	and $3F
	ret nz

	ld (ix+ALIEN.anim), $00
	add ix, de
	add ix, de
	jr .spawn_ball

.into_next:
	ld (ix+ALIEN.anim), $00
	add ix, de
.spawn_ball:
	ld (ix+ALIEN.state), $05
	ld a, c
	ld (ix+ALIEN.x), a
	ld a, b
	add a, $04
	ld (ix+ALIEN.y), a

	ld hl, TEMPLATE_ROUND
	jp copy_alien_template

.destroyed:
	ld l, (ix+ALIEN.param1)
	ld h, (ix+ALIEN.param2)
	ld (hl), CANNON_KILL	; cannon destroyed

	ld hl, VANISH_MED			; cannon disappearing

	call start_vanish
	call cannon_map_cell

	ld de, $0020
	ld a, (THEME_PARAM)
	ld b, a
.clear_loop:
	add hl, de
	ld a, (hl)
	and a
	jr z, .clear_loop

	cp b
	jp nz, award_alien_score

	ld (hl), $00
	ld c, h
	inc h
	inc h
	inc h
	ld (hl), $01
	ld h, c

	jr .clear_loop


cannon_map_cell:
	ld a, (ix+ALIEN.y)
	add a, $04
	and $F8
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld a, (ix+ALIEN.x)
	sub $40
	srl a
	srl a
	ld e, a
	ld d, $00
	add hl, de
	ld de, MAP_CANNON
	add hl, de

	ret
