LA2D0:
	call LB276

	ld a, (LA2CE)
	ld (LA2CD), a

	ld e, a
	ld d, $00
	ld iy, COLORS_PLAYER
	add iy, de
	ld ix, LA43F
	ld b, $08

LA2D0_0:
	ld a, (ix+$00)
	and $BF
	jr z, LA2D0_1

	push bc

	call LA349
	call LA56F

	pop bc

LA2D0_1:
	ld de, $0026
	add ix, de
	djnz LA2D0_0

	call playfield_to_screen

	ld ix, ALIEN.6
	ld a, $08

LA2D0_2:
	push af
	ld a, (ix + ALIEN._00)
	and $BF
	jr z, LA2D0_5

	ld de, $0020
	ld c, (ix + ALIEN._0E)
	ld b, (ix + ALIEN._0F)
	ld h, (ix + ALIEN._0A)
	ld l, (ix + ALIEN._09)
	ld a, (ix + ALIEN._05)
	inc a
	ld (ix + ALIEN._07), a

LA2D0_3:
	ld a, (ix + ALIEN._06)
	inc a
	push hl

LA2D0_4:
	ex af, af'
	ld a, (bc)
	inc bc
	ld (hl), a
	add hl, de
	ex af, af'
	dec a
	jp nz, LA2D0_4

	pop hl
	inc hl
	dec (ix + ALIEN._07)
	jp nz, LA2D0_3

LA2D0_5:
	pop af
	ld de, $FFDA	; -38
	add ix, de
	dec a
	jp nz, LA2D0_2

	jp LB2C5
