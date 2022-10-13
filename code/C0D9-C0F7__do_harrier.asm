do_harrier:
	ld a, (LC0D6)
	and a
	ret nz

	ld (ix+$00),8
	ld (ix+$04), $32
	ld a, $FF
	ld (LC0D6), a
	ld hl, $0300
	ld (LC0D7), hl

	ld hl, TEMPLATE_HARRIER

	jp copy_alien_template
