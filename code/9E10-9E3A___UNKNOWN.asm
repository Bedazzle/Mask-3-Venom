L9E10:
	ld hl, $50A0
	ld d, $00
L9E10_0:
	dec l
	ld a, l

	cp $FF
	jr nz, L9E10_1

	ld a, h
	sub $08
	ld h, a
L9E10_1:
	ld e, h

	DUP 7
	 ld (hl), d
	 inc h
	EDUP

	ld (hl), d
	ld h, e
	ld a, l

	cp $E0
	jr nz, L9E10_0

	ld a, h

	cp $40
	jr nz, L9E10_0

	ret
