; --- move_snake_head (alien state, vector 18) ----------------
; @done
; Lead snake segment: undulate vertically (param1 phase drives
; param2) while creeping left. In: ix = alien
move_snake_head:
	ld a, (ix+ALIEN.hit)
	and a
	jr z, .alive

	call alien_killed

	ld (ix+ALIEN.xvel), $FF

	ret

.alive:
	ld a, (ix+ALIEN.y)
	ld (ix+ALIEN.yvel), a
	inc (ix+ALIEN.param1)
	bit 3, (ix+ALIEN.param1)
	jr z, .alt

	inc (ix+ALIEN.param2)
	jr .move


.alt:
	dec (ix+ALIEN.param2)

.move:
	ld a, (ix+ALIEN.y)
	add a, (ix+ALIEN.param2)
	ld (ix+ALIEN.y), a
	dec (ix+ALIEN.x)

	call alien_hits_player
	jp z, decrease_energy

	ret
