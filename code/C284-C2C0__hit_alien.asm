; --- hit_alien -------------------------------------------------
; @done
; Player bullet vs aliens: scan the 6 alien slots and apply a hit
; (damage/kill + score) to any overlapping the bullet.
hit_alien:
	ld ix, ALIEN.1



	ld b, $06

loop_next_hit:
	push bc
	push ix

	call choose_alien_routine

	ld (ix+ALIEN.hit), $00

	call bullet_hits_alien

	jr nz, .was_hit

	dec (ix+ALIEN.hp)

.damage_bullet:
	ld iy, PLAYER_BULLET
	dec (iy+ALIEN.hp)
	jr nz, .run_state

	ld (iy+ALIEN.state), $00
	jr .run_state

.was_hit:
	ld a, (ix+ALIEN.hit)
	and a
	jr nz, .damage_bullet

.run_state:
	call alien_vectors

	pop ix
	pop bc
	ld de, ALIEN_LEN
	add ix, de
	djnz loop_next_hit

	jp spawn_boss
