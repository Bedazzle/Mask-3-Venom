; --- stamp_boxes ---------------------------------------------
; @done
; Draw the two collectible weapon boxes (BOX.1, BOX.2) into the
; playfield map, first saving the 2x2 tiles they cover into SAVED_BOX_TILES
; so restore_boxes can undo it afterwards. Writes the box's four
; glyph tiles (from BOX.TILE) plus a two-cell bottom border.
; Skips a box whose X is $FF (inactive). Runs at the top of
; draw_all_actors; leaves the saved-tiles cursor in DRAW_DEST.
stamp_boxes:
	ld de, SAVED_BOX_TILES

	ld ix, BOX.1
	call .box

	ld ix, BOX.2
	call .box

	ld (DRAW_DEST), de
.box:
	ld a, (ix + BOX.X)
	inc a
	ret z

	ld l, (ix + BOX.BUFF_LO)
	ld h, (ix + BOX.BUFF_HI)
	push hl
	ld c, (ix + BOX.TILE)

	ld b, $02
.rows:
	ld a, (hl)
	ld (de), a
	inc de
	ld (hl), c
	inc l
	ld a, (hl)
	ld (de), a
	inc de
	inc c
	inc c
	ld (hl), c
	dec c
	ld a, l
	add a, $1F
	ld l, a
	jr nc, .wrap1

	inc h
.wrap1:
	djnz .rows

	pop hl
	inc h
	inc h
	inc h
	ld c, $02

	ld (hl), c
	inc l
	ld (hl), c
	ld a, l
	add a, $1F
	ld l, a
	jr nc, .wrap2

	inc h
.wrap2:
	ld (hl), c
	inc l
	ld (hl), c

	ret
