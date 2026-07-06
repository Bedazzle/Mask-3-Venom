; --- state_vanish (alien state, vector 3) --------------------
; @done
; Disappearing animation (entered via start_vanish): count the
; timer down while animating + moving, then free the slot.
; In: ix = alien
state_vanish:
	dec (ix+ALIEN.timer)
	jr nz, .animate

	ld (ix+ALIEN.state), $00

	ret
.animate:
	inc (ix+ALIEN.anim)

	jp move_alien
