; --- restore_boxes -------------------------------------------
; @done
; Undo stamp_boxes: copy the tiles it saved in SAVED_BOX_TILES back under
; each box (BOX.1, BOX.2), keeping the playfield map clean for the
; next frame. Skips inactive boxes (X = $FF). Runs at the end of
; draw_all_actors.
restore_boxes:
	ld de, SAVED_BOX_TILES

	ld ix, BOX.1
	call .box

	ld ix, BOX.2
.box:
	ld a, (ix + BOX.X)
	inc a
	ret z

	ld l, (ix + BOX.BUFF_LO)
	ld h, (ix + BOX.BUFF_HI)


	ld b, $02
.rows:
	ld a, (de)
	inc de
	ld (hl), a
	inc l

	ld a, (de)
	inc de
	ld (hl), a
	ld a, l
	add a, $1F
	ld l, a
	jr nc, .wrap

	inc h
.wrap:
	djnz .rows

	ret
