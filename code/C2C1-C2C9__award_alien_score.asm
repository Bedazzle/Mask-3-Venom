; --- award_alien_score ---------------------------------------
; @done
; Add this alien's score value (score_hi:score_lo) to the player
; score. In: ix = alien
award_alien_score:
	ld d, (ix+ALIEN.score_hi)
	ld e, (ix+ALIEN.score_lo)

	jp increase_score
