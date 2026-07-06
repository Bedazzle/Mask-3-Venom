ROTATORS:
	DS $10		; 4 records x 4: x, y, cell_lo, cell_hi


; --- find_rotators --------------------------------------------
; @done
; Find every rotator tile (ROTATOR_OK = $1B) in the current room
; (up to 3) and record each one's coordinates and map-cell
; pointer in the ROTATORS table; unused records stay zeroed.
find_rotators:
	ld ix, ROTATORS
	ld de, ROTATOR_LEN
	ld b, $04
.clear:
	ld (ix+ROTATOR.X), $00
	add ix, de
	djnz .clear

	ld a, ROTATOR_OK

	call find_room_tile
	ret z

	ld ix, ROTATORS
	ld de, ROTATOR_LEN
	ld h, $03		; store up to 3
.store:
	ld a, b
	add a, $04
	ld (ix+ROTATOR.X), a
	ld a, c
	add a, $08
	ld (ix+ROTATOR.Y), a
	exx
	ld (ix+ROTATOR.CELL_LO), l		; map cell pointer
	ld (ix+ROTATOR.CELL_HI), h
	exx
	add ix, de

	call find_room_tile_next
	ret z

	dec h
	jr nz, .store

	ret
