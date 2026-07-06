; --- do_jumpers ------------------------------------------------
; @done
; Maybe spawn a jumper (state 6): a random gate, and only while
; the player is left of x $91.
; In: ix = alien slot
do_jumpers:
	call generate_random

	and $44
	ret nz

	ld a, (PLAYER_X_COORD)
	cp $91
	ret nc

	ld (ix+ALIEN.state), $06

	call generate_random

	and $0F
	add a, $C6
	ld (ix+ALIEN.x), a

	call generate_random

	and $07
	ld (ix+ALIEN.param1), a

	ld hl, TEMPLATE_JUMPER

	jp copy_alien_template
