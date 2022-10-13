draw_boxes:
	ld hl, BOXES
	ld de, $0004
	ld a, (LEVEL_NUMBER)
	ld c, a
	ld a, (ROOM_NUMBER)
	add a, a	; x2
	add a, a	; x4
	ld b, a
	exx

	ld ix, BOX.1
	call draw_box

	ld ix, BOX.2
draw_box:
	ld (ix + BOX.X), $FF

	call LAA59

	cp $FF
	ret z

	exx
	ld (ix + BOX.LO), l
	ld (ix + BOX.HI), h

	inc hl
	ld a, (hl)
	ld (ix + BOX.TYPE), a

	inc hl
	ld a, (hl)
	ld (ix + BOX.X), a

	inc hl
	ld a, (hl)
	ld (ix + BOX.Y), a

	inc hl
	ld a, (ix + BOX.X)
	sub b
	exx
	ld e, a
	ld d, $00

	ld a, (ix + BOX.Y)
	ld l, a
	ld h, $00
	add hl, hl		; x2
	add hl, hl		; x4
	add hl, hl		; x8
	add hl, hl		; x16
	add hl, hl		; x32
	add hl, de
	ld de, LF0C0
	add hl, de		; HL = LF0C0 + BOX.Y*32

	ld (ix + BOX.BUFF_LO), l
	ld (ix + BOX.BUFF_HI), h

	ld a, (LA2CE)
	ld l, a
	ld (ix + BOX._07), a
	add a, $04
	ld (LA2CE), a

	ld h, $1D
	add hl, hl		; x2
	add hl, hl		; x4
	add hl, hl		; x8
	push hl

	ld l, (ix + BOX.TYPE)
	ld h, $00
	add hl, hl		; x2
	add hl, hl		; x4
	add hl, hl		; x8
	add hl, hl		; x16
	add hl, hl		; x32
	ld de, SPRITE_WEAPON
	add hl, de

	pop de
	ld bc, $0020
	ldir
	sub $04
	ld c, a
	ld b, high COLORS_PLAYER		;$EE

	ld a, (ix + BOX.TYPE)
	ld l, a
	ld h, $00
	ld de, BOX.COLORS
	add hl, de

	ld a, (hl)
	or $40
	ld (bc), a
	inc c
	ld (bc), a
	inc c
	ld (bc), a
	inc c
	ld (bc), a

	ret


LAA59:
	exx
LAA59_0:
	ld a, (hl)

	cp $FF
	exx
	ret z

	exx
	cp c
	jr z, LAA59_2

LAA59_1:
	add hl, de
	jr LAA59_0

LAA59_2:
	inc hl
	inc hl
	ld a, (hl)
	dec hl
	dec hl
	sub b

	cp $20
	jr nc, LAA59_1

	exx

	ret
