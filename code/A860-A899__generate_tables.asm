; --- generate_tables -------------------------------------------
; @done
; Build the multicolour EXPAND_LUT and MIRROR_LUT lookup tables
; (one-time, at startup).
generate_tables:
	ld hl, EXPAND_LUT
.build_expand:
	ld a, l
	ld d, l
	add a, a
	srl d
	or d
	or l
	ld (hl), a
	inc l
	jr nz, .build_expand

	ld hl, PIXEL_COL_LUT	; 0,0,0,0,1,1,1,1,2,2,2,2....
.build_pixcol:
	ld e, h
	ld b, $00
	ld a, l
	ld d, $03		; 3x2=6 blocks
.pixcol_bits:
	srl a
	rr b
	rra
	rr b
	ld (hl), a
	inc h
	ld (hl), b
	inc h
	dec d
	jr nz, .pixcol_bits

	ld h, e
	inc l
	jr nz, .build_pixcol

	ld hl, MIRROR_LUT	; MIRRORTABLE
mirror_table:
	ld a, l
	ld b, $08

mirror_byte:
	srl a
	rl e
	djnz mirror_byte

	ld (hl), e
	inc l
	jr nz, mirror_table

	ret
