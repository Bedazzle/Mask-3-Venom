; --- alien_killed --------------------------------------------
; @done
; The player's weapon hit this alien: award its score and switch
; it to state_rise ($0A) to fly up and vanish. Cannonballs (state 5)
; get param1=$40. In: ix = alien
alien_killed:
	call award_alien_score
	ld a, (ix+ALIEN.state)
	ld (ix+ALIEN.state), $0A
	ld (ix+ALIEN.xvel), $00
	cp $05
	jr z, .set_param1
	ld (ix+ALIEN.param1), $00
	ret


.set_param1:
	ld (ix+ALIEN.param1), $40
	ret
