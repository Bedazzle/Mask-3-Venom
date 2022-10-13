L94C8:
	ld a, (L94AB)
	and a
	ret z

	cp $FF
	jr z, L94C8_0

	dec a
	ld (L94AB), a
L94C8_0:
	ld ix, (L94AB+3)
	ld hl, (L94AB+1)
	ld e, (ix+$07)
	ld d, (ix+$08)
	add hl, de
	ld (L94AB+1), hl
	xor a
	sub l
	srl a
	srl a
	srl a
	srl a
	srl a
	inc a
	ld b, a
L94C8_1:
    ld a, (L9225)
	or $18
	out ($FE), a	; buzz
	ld h, l
L94C8_2:
	dec h
	jr nz, L94C8_2

	ld a, (L9225)
	out ($FE), a	; buzz
	ld h, l
L94C8_3:
	jr nz, L94C8_3

	djnz L94C8_1

	ret
