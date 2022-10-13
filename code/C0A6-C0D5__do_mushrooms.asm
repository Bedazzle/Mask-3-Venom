do_mushrooms:
	ld a, (ix+$1F)
	and a
	ret nz

	ld (ix+$1F), $FF
	ld (ix+$00), $07

	ld hl, TEMPLATE_MUSHROOM

	call copy_alien_template

	ld (ix+$03), $C6
	ld a, (LAC7F)
	sub $0F
	ld (ix+$04), a
	ld (ix+$1B), $FE
	ld (ix+$1C), $14
	ld (ix+$11), $00
	ld (ix+$12), $01

	ret
