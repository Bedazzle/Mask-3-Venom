do_bomber:
	ld a, (ix+$1F)
	and a
	ret nz

	ld a, $0A

	call L93DC
	call kill_all_aliens

	ld (ix+$00), $10
	ld (ix+$03), $DC
	ld (ix+$04), $00

	ld hl, TEMPLATE_BOMBER

	jp copy_alien_template
