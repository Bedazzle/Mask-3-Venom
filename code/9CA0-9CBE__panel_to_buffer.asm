panel_to_buffer:
	ld hl, $5040	; bitmap address
	ld de, LF600
	ld c, h

copy_cells:
	ld b, $08		; 8 bytes in cell
loop_copy_cell:
	ld a, (hl)
	inc h
	ld (de), a
	inc de
	djnz loop_copy_cell

	ld h, c
	inc l
	jr nz, copy_cells

	ld hl, $5A40	; attr address
	ld de, LFC64
	ld bc, $00C0
	ldir

	ret
