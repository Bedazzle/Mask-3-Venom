do_jumpers:
	call generate_random

	and $44
	ret nz

	ld a, (PLAYER_X_COORD)
	cp $91
	ret nc

	ld (ix+$00), $06

	call generate_random

	and $0F
	add a, $C6
	ld (ix+$03), a

	call generate_random

	and $07
	ld (ix+$11), a

	ld hl, TEMPLATE_JUMPER

	jp copy_alien_template
