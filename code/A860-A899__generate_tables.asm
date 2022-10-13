generate_tables:
	ld hl, LF700
LA860_0:
	ld a, l
	ld d, l
	add a, a
	srl d
	or d
	or l
	ld (hl), a
	inc l
	jr nz, LA860_0

	ld hl, LF800	; 0,0,0,0,1,1,1,1,2,2,2,2....
LA860_1:
	ld e, h
	ld b, $00
	ld a, l
	ld d, $03		; 3x2=6 blocks
LA860_2:
	srl a
	rr b
	rra
	rr b
	ld (hl), a
	inc h
	ld (hl), b
	inc h
	dec d
	jr nz, LA860_2

	ld h, e
	inc l
	jr nz, LA860_1

	ld hl, LF600	; MIRRORTABLE
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
