; --- move_volcano (alien state, vector 12) -------------------
; @done
; Volcano projectile: arc under gravity (yvel increments each
; frame), then vanish. In: ix = alien
move_volcano:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .dead

	ld a, (ix+ALIEN.hit)
	and a
	jp nz, alien_killed

	ld a, (ix+ALIEN.anim)
	add a, (ix+ALIEN.param1)
	ld (ix+ALIEN.anim), a

	call move_alien_x

	cp $30
	jr c, .vanish

	cp $C0
	jr nc, .vanish

	ld a, (ix+ALIEN.y)
	add a, (ix+ALIEN.yvel)
	ld (ix+ALIEN.y), a
	inc (ix+ALIEN.yvel)
	add a, $20

	cp $86
	jr nc, .vanish

	call alien_hits_player
	jr z, .hit

	call alien_hits_wall
	jr c, .vanish

	ret


.hit:
	call decrease_energy

.dead:
	call award_alien_score

.vanish:
	ld hl, VANISH_SMALL

	jp start_vanish
