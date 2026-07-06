; --- draw_energy -----------------------------------------------
; @done
; Draw the energy bar in the HUD panel from the ENERGY value.
draw_energy:
	ld a, (ENERGY)
	srl a
	srl a
	ld hl, ENERGY_TMP

	cp (hl)
	ld (hl), a
	ret z

	ld e, a
	ld hl, $506D	; screen location for energy bar, bitmap
	srl a
	srl a
	srl a
	jr z, draw_energy_1

	ld b, a
	ld c, $FF

loop_draw_energy:
	call draw_energy_bar

	djnz loop_draw_energy

draw_energy_1:
	ld a, e
	and $07
	ld de, ENERGY_BAR_DATA
	add a, e
	ld e, a
	jp nc, draw_energy_2

	inc d

draw_energy_2:
	ld a, (de)
	ld c, a

	call draw_energy_bar

	ld c, $00

draw_energy_3:
	ld a, l

	cp $75
	ret z

	call draw_energy_bar

	jr draw_energy_3


draw_energy_bar:
	push hl
	push bc
	ld b, $03
.bar_loop:
	ld a, h

	DUP 7
	 ld (hl), c
	 inc h
	EDUP

	ld (hl), c
	ld h, a
	ld a, l
	add a, $20
	ld l, a
	djnz .bar_loop

	pop bc
	pop hl
	inc l

	ret

ENERGY_BAR_DATA:
	;defb $00,$80,$C0,$E0,$F0,$F8,$FC,$FE
	DB 0, -128, -64, -32, -16, -8, -4, -2
