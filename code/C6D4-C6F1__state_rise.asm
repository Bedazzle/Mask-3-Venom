; --- state_rise (alien state, vector 10) ---------------------
; @done
; Death animation (entered via alien_killed): the shot alien
; rises (y -= 8) and, once off the top, switches to its param1
; follow-up state. In: ix = alien
state_rise:
	ld a, (ix+ALIEN.y)
	ld (ix+ALIEN.yvel), a
	sub $08
	ld (ix+ALIEN.y), a

	call move_alien_x

	ld a, (ix+ALIEN.y)
	bit $07, a
	ret z

	cp $E0
	ret nc

	ld a, (ix+ALIEN.param1)
	ld (ix+ALIEN.state), a

	ret
