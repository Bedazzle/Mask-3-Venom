; --- wipe_screen ----------------------------------------------
; @done
; Clear the screen bitmap as a two-way wipe: one pointer erases
; scanlines from the top ($4000 downward), the other from the
; bottom ($57A0 upward), one 32-byte line from each per frame
; (halt-synced) until they meet. The screen-third boundaries are
; handled by the +/- $08 high-byte adjustments.
wipe_screen:
	ld hl, $57A0		; bottom pointer (alt set)
	exx
	ld hl, $4000		; top pointer (main set)
	ld b, $58		; 88 line-pairs

.frame:
	halt
	exx

	call .clear_line	; erase a bottom line

	dec h
	ld a, h
	and $07

	cp $07
	jr nz, .do_top

	ld a, l
	sub $20
	ld l, a
	jr c, .do_top

	ld a, h
	add a, $08
	ld h, a

.do_top:
	exx

	call .clear_line	; erase a top line

	inc h
	ld a, h
	and $07
	jr nz, .next_frame

	ld a, l
	add a, $20
	ld l, a
	jr c, .next_frame

	ld a, h
	sub $08
	ld h, a

.next_frame:
	djnz .frame

.clear_line:
	ld e, l
	ld d, $20		; 32 bytes

.fill:
	ld (hl), $00
	inc l
	dec d
	jr nz, .fill

	ld l, e

	ret
