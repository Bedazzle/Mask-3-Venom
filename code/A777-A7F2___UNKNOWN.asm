LA777:
	ld b, $F7
	ld de, DATA_BLOCK1
	ld l, (ix+$0C)
	ld h, (ix+$0D)
	exx
	ld c, (ix+$05)

LA777_0:
	exx
	xor a
	ex af, af'
	ld a, (ix+$06)

LA777_1:
	ex af, af'

	DUP 7
		or (hl)
		inc l
		or (hl)
		ld c, a
		ld a, (bc)
		ld (de), a
		inc e
		dec l
		ld a, (hl)
		inc l
	EDUP

	; -----------
		or (hl)
		inc hl		; !!!
		or (hl)
		ld c, a
		ld a, (bc)
		ld (de), a
		inc de		; !!!
		dec hl		; !!!
		ld a, (hl)
		inc hl		; !!!
	; -----------

	ex af, af'

	dec a
	jp nz, LA777_1

	dec hl
	dec hl
	ld a, (hl)
	inc hl
	or (hl)
	inc hl
	ld c, a
	ld a, (bc)
	dec de
	ld (de), a
	inc de
	exx
	dec c
	jp nz, LA777_0

	ret
