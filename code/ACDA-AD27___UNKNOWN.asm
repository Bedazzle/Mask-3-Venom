LACDA:
	defs $10

LACEA:
	ld ix, LACDA
	ld de, $0004
	ld b, $04

LACEA_0:
	ld (ix+$00), $00
	add ix, de
	djnz LACEA_0

	ld a, $1B

	call LABFD
	ret z

	ld ix, LACDA
	ld de, $0004
	ld h, $03

LACEA_1:
	ld a, b
	add a, $04
	ld (ix+$00), a
	ld a, c
	add a, $08
	ld (ix+$01), a
	exx
	ld (ix+$02), l
	ld (ix+$03), h
	exx
	add ix, de

	call LAC2F
	ret z

	dec h
	jr nz, LACEA_1

	ret
