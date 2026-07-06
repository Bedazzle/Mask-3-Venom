; --- move_cannonball (alien state, vector 5) -----------------
; @done
; The round fired by move_cannon: travel left until x < $40, then
; expire. Tracks the parent cannon record (ix-ALIEN_LEN).
; In: ix = alien
move_cannonball:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .dead

	ld a, (ix+ALIEN.hit)
	and a
	jp nz, alien_killed

	inc (ix+ALIEN.anim)
	ld a, (ix+ALIEN.x)
	sub $02
	ld (ix+ALIEN.x), a

	cp $40
	jr c, .check_parent

	call alien_hits_player
	ret nz

	ld a, (ix-ALIEN_LEN+ALIEN.state)

	cp $04
	ret nz

	ld (ix+ALIEN.state), $40

	jp decrease_energy

.dead:
	call award_alien_score
.check_parent:
	ld a, (ix-ALIEN_LEN+ALIEN.state)

	cp $04
	jr nz, .despawn

	ld (ix+ALIEN.state), $40

	ret
.despawn:
	ld (ix+ALIEN.state), $00

	ret
