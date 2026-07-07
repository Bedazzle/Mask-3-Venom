; --- find_ground_row: scan the room map for the ground tile (bit-7 bg colour); store its Y in GROUND_ROW (move_jumper arc base) (@done)
find_ground_row:
	xor a
	ex af, af'
	ld hl, PLAYFIELD_MAP
	ld de, $0020
	ld b, $EF
.scan:
	ld c, (hl)
	ld a, (bc)
	bit 7, a
	jr nz, .found
	add hl, de
	ex af, af'
	add a, $08
	ex af, af'
	jr .scan
.found:
	ex af, af'
	ld (GROUND_ROW), a
	ret
