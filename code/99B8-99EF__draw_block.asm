; --- draw_block -----------------------------------------------
; @done
; Blit a rectangular block of 8x8 character cells to the screen.
; Each cell is 8 source bytes (one byte per pixel row); cells are
; laid out column-major within a row, then the next row. The
; per-row screen advance (32 - width) and the width reload are
; patched in via SMC so the inner loops stay tight.
; In:  hl = source graphics, d = row, e = column,
;      b = width in cells, c = height in cells
draw_block:
	push hl
	push de
	push bc
	push hl

	call find_bmp_addr	; d=row, e=column -> hl = screen addr

	ld a, $20
	sub b
	ld (.row_adv+1), a	; SMC: row advance = 32 - width
	ld a, b
	ld (.next_row+1), a	; SMC: width reload
	pop de			; de = source graphics

.column:
	push bc
	ld b, $04		; 4 x 2 = 8 pixel rows
	ld c, h			; save screen high byte
.rows:
	ld a, (de)
	inc de
	ld (hl), a
	inc h
	ld a, (de)
	inc de
	ld (hl), a
	inc h
	djnz .rows

	ld h, c
	inc l			; next cell column
	pop bc
	djnz .column

	ld a, l

.row_adv:
	add a, $00		; !!! SMC: += (32 - width)
	ld l, a
	jr nc, .next_row

	ld a, h
	add a, $08		; cross into next screen third
	ld h, a

.next_row:
	ld b, $00		; !!! SMC: reload width
	dec c
	jr nz, .column

	pop bc
	pop de
	pop hl

	ret
