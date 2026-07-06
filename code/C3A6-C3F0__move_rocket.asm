; --- move_rocket (alien state, vector 2) ---------------------
; @done
; Rocket: fly left while homing vertically toward the player
; (param1 = aim offset); despawn once past x < $28.
; In: ix = alien
move_rocket:
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

	cp $28
	jr c, .despawn

	ld a, (PLAYER_Y_COORD)
	add a, (ix+ALIEN.param1)

	cp (ix+ALIEN.y)
	jr z, .aimed
	jr c, .aim_down

	inc (ix+ALIEN.y)
	jr .aimed

.aim_down:
	dec (ix+ALIEN.y)
.aimed:
	call alien_hits_wall
	jr c, .vanish

	call alien_hits_player
	ret nz

	call decrease_energy

.dead:
	call award_alien_score
.vanish:
	ld hl, VANISH_MED	; rocket disappearing by collision

	jp start_vanish

.despawn:
	ld (ix+ALIEN.state), $00

	ret
