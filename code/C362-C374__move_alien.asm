; --- move_alien ----------------------------------------------
; @done
; Advance the alien by its velocity: y += yvel, then x += xvel.
; move_alien_x is the x-only entry point. In: ix = alien
move_alien:
	ld a, (ix+ALIEN.y)
	add a, (ix+ALIEN.yvel)
	ld (ix+ALIEN.y), a
; This entry point is used by the routine at move_mushroom.
move_alien_x:
	ld a, (ix+ALIEN.x)
	add a, (ix+ALIEN.xvel)
	ld (ix+ALIEN.x), a
	ret
