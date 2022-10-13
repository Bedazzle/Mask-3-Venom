col_row_to_attr:
	; E=x, D=y
	ex af, af'
	ld a, e

	cp $20
	jr nc, out_of_screen

	ld a, d

	cp $18
	jr nc, out_of_screen

	push hl
	ld hl, $5800
	srl d
	rr l
	srl d
	rr l
	srl d
	rr l
	add hl, de
	ld d, a
	ex af, af'
	ld (hl), a
	pop hl

	ret

out_of_screen:
	ex af, af'

	ret
