LA7F3:
	ld a, (ix+$06)
	add a, a
	add a, a
	add a, a
	ld e, a
	ld d, $00
	ld h, (ix+$0D)
	ld l, (ix+$0C)
	ld a, (ix+$05)

LA7F3_0:
	dec a
	jr z, LA7F3_1

	add hl, de
	jp LA7F3_0

LA7F3_1:
	ld a, e
	neg
	ld (LA853+1), a     ; set SMC
	ld de, LF300
	ld (ix+$0D), d
	ld (ix+$0C), e
	ld b, $F6
	exx
	ld c, (ix+$05)

LA7F3_2:
	exx
	ld a, (ix+$06)

LA7F3_3:
	ex af, af'

	DUP 7
		ld c, (hl)
		ld a, (bc)
		ld (de), a
		inc l
		inc e
	EDUP

	; -----------
		ld c, (hl)
		ld a, (bc)
		ld (de), a
		inc hl		; !!!
		inc de		; !!!
	; -----------

	ex af, af'
	dec a
	jp nz, LA7F3_3

LA853:
	ld bc, LFF00		; !!! SMC
	add hl, bc
	add hl, bc
	ld b, $F6
	exx
	dec c
	jp nz, LA7F3_2

	ret
