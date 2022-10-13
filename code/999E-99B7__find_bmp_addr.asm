; find screen bitmap address
; in: D=row, E=column
; out: HL=address
find_bmp_addr:
	ld hl, $4000
	ld a, d
	and $18
	or h
	ld h, a
	ld a, d
	and $07
	ld d, a
	srl d
	rr l
	srl d
	rr l
	srl d
	rr l
	add hl, de

	ret
