do_bomb:
	ld a, (ix+$1F)
	and a
	jp nz, LBF2B_1

	call kill_all_aliens

	ld (ix+$00), $0D	; procedure?
	ld (ix+$03), $60
	ld (ix+$04), $E2

	ld hl, TEMPLATE_BOMB

	call copy_alien_template

	ld (ix+$1C), $08
	ld (ix+$11), $00

	ret
