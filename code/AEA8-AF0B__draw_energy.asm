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
	call LAEE5

	djnz loop_draw_energy

draw_energy_1:
	ld a, e
	and $07
	ld de, LAF04
	add a, e
	ld e, a
	jp nc, draw_energy_2

	inc d

draw_energy_2:
	ld a, (de)
	ld c, a

	call LAEE5

	ld c, $00

draw_energy_3:
	ld a, l

	cp $75
	ret z

	call LAEE5

	jr draw_energy_3


LAEE5:
	push hl
	push bc
	ld b, $03
LAEE5_0:
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
	djnz LAEE5_0

	pop bc
	pop hl
	inc l

	ret

LAF04:
	;defb $00,$80,$C0,$E0,$F0,$F8,$FC,$FE
	defb 0, -128, -64, -32, -16, -8, -4, -2
