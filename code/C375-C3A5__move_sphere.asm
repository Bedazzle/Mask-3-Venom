; --- move_sphere (alien state, vector 1) ---------------------
; @done
; Sphere: animate and descend/drift (move_alien); drain the
; player's energy on contact; vanish when off-screen or dead.
; In: ix = alien
move_sphere:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .dead

	ld a, (ix+ALIEN.hit)
	and a
	jp nz, alien_killed

	inc (ix+ALIEN.anim)

	call move_alien

	ld a, (ix+ALIEN.y)
	add a, $30

	cp $A0
	jr nc, .vanish

	call alien_hits_wall
	jr c, .vanish

	call alien_hits_player

	ret nz

	call decrease_energy

.dead:
	call award_alien_score
.vanish:
	ld hl, VANISH_SMALL	; sphere disappearing

	jp start_vanish
