LB276:
	ld de, LA253

	ld ix, BOX.1
	call LB276_0

	ld ix, BOX.2
	call LB276_0

	ld (LA2CB), de
LB276_0:
	ld a, (ix + BOX.X)
	inc a
	ret z

	ld l, (ix + BOX.BUFF_LO)
	ld h, (ix + BOX.BUFF_HI)
	push hl
	ld c, (ix + BOX._07)

	ld b, $02
LB276_1:
	ld a, (hl)
	ld (de), a
	inc de
	ld (hl), c
	inc l
	ld a, (hl)
	ld (de), a
	inc de
	inc c
	inc c
	ld (hl), c
	dec c
	ld a, l
	add a, $1F
	ld l, a
	jr nc, LB276_2

	inc h
LB276_2:
	djnz LB276_1

	pop hl
	inc h
	inc h
	inc h
	ld c, $02

	ld (hl), c
	inc l
	ld (hl), c
	ld a, l
	add a, $1F
	ld l, a
	jr nc, LB276_3

	inc h
LB276_3:
	ld (hl), c
	inc l
	ld (hl), c

	ret
