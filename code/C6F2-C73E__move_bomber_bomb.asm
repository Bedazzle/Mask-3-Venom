; --- move_bomber_bomb (alien state, vector 11) ---------------
; @done
; The bomb dropped by move_bomber: fall (y += 4) and, on impact
; or player contact, burst into a disappear effect.
; In: ix = alien
move_bomber_bomb:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .dead

	ld a, (ix+ALIEN.hit)
	and a
	jp nz, alien_killed

	inc (ix+ALIEN.anim)
	ld a, (ix+ALIEN.y)
	add a, $04
	ld (ix+ALIEN.y), a
	add a, $30

	cp $A0
	jr nc, .vanish

	call alien_hits_player
	jr z, .hit

	call alien_hits_wall
	ret nc

	jr .vanish


.hit:
	call decrease_energy

.dead:
	call award_alien_score

.vanish:
	ld hl, VANISH_BOMB1		; bomber bomb dissapearing 1

	call generate_random

	rrca
	jr c, .do_vanish

	ld hl, VANISH_BOMB2		; bomber bomb dissapearing 1

.do_vanish:
	call start_vanish

	dec (ix+ALIEN.x)
	dec (ix+ALIEN.x)
	ld (ix+ALIEN.yvel), $02
	ld a, $0B

	jp play_sfx
