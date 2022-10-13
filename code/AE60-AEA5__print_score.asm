print_score:
	ld l, $77
	exx
	ld de, SCORE_BUFFER
	ld b, $04	; 4 times x2 nibbles = 8 digits score

loop_big_digits:
	ld a, (de)	; get upper nibble
	rrca
	rrca
	rrca
	rrca

	call print_big_digit

	ld a, (de)	; get lower nibble
	inc de

	call print_big_digit

	djnz loop_big_digits

	ret


print_big_digit:
	exx
	and $0F		; clear upper nibble
	add a, a	; x2
	add a, a	; x4
	add a, a	; x8
	add a, a	; x16	- big font digits are 16x8 pix
	ld de, BIG_FONT
	add a, e
	ld e, a
	jr nc, digit_cross_addr
	
	inc d
digit_cross_addr:
	ld c,l
	ld a, $02		; two cells (16 pix) height
loop_digit_rows:
	ex af, af'
	ld h, $50 - 8*256		; screen address
	ld b, $04		; 4 times 2 bytes = 8 bytes = 1 cell
loop_digit_cell:
	DUP 2
		ld a, (de)
		inc de
		ld (hl), a
		inc h
	EDUP

	djnz loop_digit_cell

	ld a, c
	add a, $20
	ld l, a
	ex af, af'
	dec a
	jp nz, loop_digit_rows

	ld l, c
	inc l
	exx

	ret
