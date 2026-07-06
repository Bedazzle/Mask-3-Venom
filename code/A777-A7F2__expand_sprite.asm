; --- expand_sprite -------------------------------------------
; @done
; Translate the selected sprite through the multicolour lookup
; table at $F700 into the work buffer (DATA_BLOCK1), combining
; adjacent columns for the two-bit-per-pixel format.
; In: ix = actor (uses ALIEN.spr, width, height)
expand_sprite:
	ld b, $F7
	ld de, DATA_BLOCK1
	ld l, (ix+ALIEN.spr_lo)
	ld h, (ix+ALIEN.spr_hi)
	exx
	ld c, (ix+ALIEN.width)

.col:
	exx
	xor a
	ex af, af'
	ld a, (ix+ALIEN.height)

.row:
	ex af, af'

	DUP 7
		or (hl)
		inc l
		or (hl)
		ld c, a
		ld a, (bc)
		ld (de), a
		inc e
		dec l
		ld a, (hl)
		inc l
	EDUP

	; -----------
		or (hl)
		inc hl		; !!!
		or (hl)
		ld c, a
		ld a, (bc)
		ld (de), a
		inc de		; !!!
		dec hl		; !!!
		ld a, (hl)
		inc hl		; !!!
	; -----------

	ex af, af'

	dec a
	jp nz, .row

	dec hl
	dec hl
	ld a, (hl)
	inc hl
	or (hl)
	inc hl
	ld c, a
	ld a, (bc)
	dec de
	ld (de), a
	inc de
	exx
	dec c
	jp nz, .col

	ret
