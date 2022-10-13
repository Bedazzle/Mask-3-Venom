; in: HL - address of password to match
; out: Z set if full match

match_buffer:
	ld de, PASS_BUFFER
next_char:
	ld a, (de)
	cp (hl)
	ret nz

	ld a, (hl)
	and a
	ret z

	inc de
	inc hl
	jr next_char
