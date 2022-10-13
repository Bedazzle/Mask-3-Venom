LB2C5:
	ld de, LA253

	ld ix, BOX.1
	call LB2C5_0

	ld ix, BOX.2
LB2C5_0:
	ld a, (ix + BOX.X)
	inc a
	ret z

	ld l, (ix + BOX.BUFF_LO)
	ld h, (ix + BOX.BUFF_HI)

	;display $	; F252	F256

	ld b, $02
LB2C5_1:
	ld a, (de)
	inc de
	ld (hl), a
	inc l

	ld a, (de)
	inc de
	ld (hl), a
	ld a, l
	add a, $1F
	ld l, a
	jr nc, LB2C5_2

	inc h
LB2C5_2:
	djnz LB2C5_1

	ret
