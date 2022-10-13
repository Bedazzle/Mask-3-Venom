decrease_penetrator:
	ld a, (LA194)

	cp $02
	ret nz

	ld ix, SLOT.1
	ld de, $0004
	ld b, $04

LADD2_0:
	ld a, (ix+SLOT.WEAPON)
	dec a
	jr nz, LADD2_1

	ld (ix+SLOT.WEAPON), $00
	ld (ix+SLOT.LOAD), $00
LADD2_1:
	add ix, de
	djnz LADD2_0

	jp slot_blinking
