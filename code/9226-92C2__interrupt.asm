; --- interrupt -------------------------------------------------
; @done
; IM2 interrupt handler (per frame): border, menu draw, sound
; engine, 128K paging, message scroller, and the fire-to-exit check.
interrupt:
	push af
	ex af, af'
	push af
	push hl
	push de
	push bc
	exx
	push hl
	push de
	push bc
	push ix
	push iy

	ld hl, FRAME_COUNTER
	inc (hl)

	ld a, (BORDER_VALUE)
	out ($FE), a

	ld a, (IN_MENU)
	and a

	call z, check_cheat_password
	call nz, draw_main_menu

	ld a, (IS_128K)
	and a
	jr nz, .sound

	ld bc, $7FFD
	ld a, $14
	out (c), a

	ld a, (SND_TRIG_1)
	and a
	jr z, .flag2

	dec a

	call copy_from_base_lo

	xor a
	ld (SND_TRIG_1), a
.flag2:
	ld a, (SND_TRIG_2)
	and a
	jr z, .frame_calls

	call copy_from_damage

	xor a
	ld (SND_TRIG_2), a

.frame_calls:
	call clear_alien_vectors
	call process_sfx_channels
	call copy_from_base_hi

	ld a, (HUD_ACTIVE)
	and a
	jr z, .repage

	ld a, (base_hi_op + 1)	; outside check !

	cp $FF
	ld a, $00

	call nz, copy_from_base_lo

.repage:
	ld bc, $7FFD
	ld a, $10
	out (c), a

	jr .scroller

.sound:
	call silence_sfx_if_flagged
	call sound_tick

.scroller:
	ld a, (HUD_ACTIVE)
	and a

	call z, message_scroller

	ld a, (HUD_ACTIVE)
	and a
	jr nz, .restore

	ld a, $7F
	in a, ($FE)

	ld l, a
	ld a, $FE
	in a, ($FE)

	or l
	bit 0, a
	jp z, diagonal_clear

.restore:
	pop iy
	pop ix
	pop bc
	pop de
	pop hl
	exx
	pop bc
	pop de
	pop hl
	pop af
	ex af, af'
	pop af
	ei

	ret
