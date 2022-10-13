decode_char:
	push hl
	push de
	ld e, a
	ex af, af'
	ld a, e
	rrca
	rrca
	rrca
	rrca
	and $07

	;mult
	ld l, a
	add a, a
	add a, a
	add a, l
	ld l, a
	;mult L=A*5

	ld a, e
	and $07
	add a, l
	ld l, a
	ld h, $00
	ld de, KEYBOARD
	add hl, de
	ld a, (hl)
	pop de
	pop hl

	ret
