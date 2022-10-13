LA56F:
	ld a, (ix+$04)
	add a, $30
	and $F8
	ld (ix+$25), a
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld a, (ix+$03)
	sub $40
	ld (ix+$13), a
	sra a
	sra a
	ld e, a
	ld d, $00
	add a, a
	jr nc, LA56F_0

	ld d, $FF
LA56F_0:
	add hl, de
	ld de, DATA_BLOCK1
	add hl, de
	ld (ix+$0A), h
	ld (ix+$09), l
	ld a, (LA2CD)
	ld (ix+$0B), a
	ld b, a
	exx
	ld l, a
	ld h, high LFD00		; $FD
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, hl	; x8	HL = $FD00 + A*8
	push hl
	ex de, hl
	exx
	ld de, (LA2CB)
	ld (ix+$0E), e
	ld (ix+$0F), d
	ld a, (ix+$05)
	inc a
	ld (ix+$07), a
LA56F_1:
	push hl
	ld a, (ix+$25)
	ld (ix+$24), a
	ld a, (ix+$06)
	inc a
LA56F_2:
	push af
	push de
	ld d, high COLORS_BACKGR		; $EF
	ld e, (hl)
	ld a, h
	inc h
	inc h
	inc h
	bit 1, (hl)
	jr z, LA56F_3

	ld d, high COLORS_PLAYER		; $EE
LA56F_3:
	ld h, a
	ld a, (de)
	and a
	jr nz, LA56F_4

	ld a, (ix+$20)
LA56F_4:
	ld (iy+$00), a
	inc iy
	pop de
	ld a, (hl)
	ld (de), a

	cp $EA
	jp nc, LA56F_7

	bit 7, (ix+$13)
	jr nz, LA56F_7

	ex af, af'
	ld a, (ix+$24)

	cp $C0
	jr nc, LA56F_7

	ex af, af'
	ld (hl), b
	inc de
	inc b
	inc h
	inc h
	inc h
	ld c, (hl)
	ld (hl), $02
	bit 1, c
	exx
	ld l, a
	ld h, high LFC00		; $FC
	jr z, LA56F_5

	ld h, high LFD00		; $FD
LA56F_5:
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, hl	; x8	HL = (LFC00 ~ LFD00) + A*8

	DUP 8
		ldi
	EDUP

	exx
	dec h
	dec h
	ld a, l
	add a, $20
	ld l, a
	jr c, LA56F_6

	dec h
LA56F_6:
	ld a, (ix+$24)
	add a, $08
	ld (ix+$24), a
	pop af
	dec a
	jp nz, LA56F_2

	pop hl
	inc hl
	ld a, (ix+$13)
	add a, $04
	ld (ix+$13), a
	dec (ix+$07)
	jp nz, LA56F_1

	ld a, b
	ld (LA2CD), a
	ld (LA2CB), de
	jp LA56F_9

LA56F_7:
	exx
	ld a, e
	add a, $08
	ld e, a
	jp nc, LA56F_8

	inc d
LA56F_8:
	exx
	inc de
	inc b
	ld a, l
	add a, $20
	ld l, a
	jp nc, LA56F_6

	inc h
	jp LA56F_6

LA56F_9:
	bit 7, (ix+$02)

	call nz, LA7F3
	call LA777

	pop hl
	ld a, (ix+$04)
	and $07
	ld e, a
	ld d, $00
	add hl, de
	ld a, (ix+$03)
	and $03
	jp nz, LA56F_13

	ld bc, DATA_BLOCK1
	ld e, (ix+$0C)
	ld d, (ix+$0D)
	ld a, (ix+$05)
	ld (ix+$07), a

LA56F_10:
	ld a, (ix+$06)

LA56F_11:
	ex af, af'

	DUP 7
		ld a, (bc)
		inc c
		cpl
		and (hl)
		ex de, hl
		or (hl)
		inc l
		ex de, hl
		ld (hl), a
		inc hl
	EDUP
	
	ld a, (bc)
	inc c
	cpl
	and (hl)
	ex de, hl
	or (hl)
	inc hl			; !!!
	ex de, hl
	ld (hl), a
	inc hl

	ex af, af'
	dec a
	jr nz, LA56F_11

	ld a, l
	add a, $08
	ld l, a
	jp nc, LA56F_12

	inc h
LA56F_12:
	dec (ix+$07)
	jp nz, LA56F_10

	ret

LA56F_13:
	add a, a
	add a, $F6
	ld d, a
	ld a, (ix+$06)
	inc a
	add a, a
	add a, a
	add a, a
	ld c, a
	ld b, $00
	ld a, d
	exx
	ld h, a
	ld de, DATA_BLOCK1
	ld c, (ix+$0C)
	ld b, (ix+$0D)
	ld a, (ix+$05)
	ld (ix+$07), a

LA56F_14:
	ld a, (ix+$06)
	ld (ix+$08), a

LA56F_15:
	ld a, $04

LA56F_16:
	ex af, af'

	ld a, (bc)
	inc c
	ld l, a
	ld a, (de)
	inc e
	exx
	ld e, a
	ld a, (de)
	cpl
	and (hl)
	exx
	or (hl)
	exx
	ld (hl), a
	add hl, bc
	inc d
	ld a, (de)
	cpl
	and (hl)
	exx
	inc h
	or (hl)
	exx
	ld (hl), a
	inc hl
	exx

	ld a, (bc)
	inc bc		; !!!
	ld l, a
	ld a, (de)
	inc e
	exx
	ld e, a
	ld a, (de)
	cpl
	and (hl)
	exx
	or (hl)
	exx
	ld (hl), a
	sbc hl, bc	; !!!
	dec d		; !!!
	ld a, (de)
	cpl
	and (hl)
	exx
	dec h		; !!!
	or (hl)
	exx
	ld (hl), a
	inc hl
	exx

	ex af, af'
	dec a
	jp nz, LA56F_16

	dec (ix+$08)
	jp nz, LA56F_15

	exx
	ld a, l
	add a, $08
	ld l, a
	jr nc, LA56F_17

	inc h
LA56F_17:
	exx
	dec (ix+$07)
	jp nz, LA56F_14

	ret
