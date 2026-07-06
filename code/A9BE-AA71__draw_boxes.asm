; --- draw_boxes ------------------------------------------------
; @done
; Stamp the current level's weapon boxes (from BOXES) into the
; playfield map.
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

	call find_box_entry

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
	ld de, PLAYFIELD_MAP
	add hl, de		; HL = PLAYFIELD_MAP + BOX.Y*32

	ld (ix + BOX.BUFF_LO), l
	ld (ix + BOX.BUFF_HI), h

	ld a, (DRAW_COLOR_BASE)
	ld l, a
	ld (ix + BOX.TILE), a
	add a, $04
	ld (DRAW_COLOR_BASE), a

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


find_box_entry:
	exx
.scan:
	ld a, (hl)

	cp $FF
	exx
	ret z

	exx
	cp c
	jr z, .found

.next:
	add hl, de
	jr .scan

.found:
	inc hl
	inc hl
	ld a, (hl)
	dec hl
	dec hl
	sub b

	cp $20
	jr nc, .next

	exx

	ret
