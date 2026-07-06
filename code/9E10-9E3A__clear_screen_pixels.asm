; --- clear_screen_pixels --------------------------------------
; @done
; Zero the screen bitmap (attributes left intact), clearing one
; 8-pixel-tall character cell at a time (hl..hl+$700), walking
; cells from $50A0 down to $40E0. Used to wipe the menu /
; password / key-redefine screens.
clear_screen_pixels:
	ld hl, $50A0
	ld d, $00
.next_cell:
	dec l
	ld a, l

	cp $FF			; l wrapped past 0?
	jr nz, .same_band

	ld a, h
	sub $08			; step up a screen band
	ld h, a
.same_band:
	ld e, h			; save top-row high byte

	DUP 7
		ld (hl), d
		inc h
	EDUP

	ld (hl), d		; 8th pixel row
	ld h, e
	ld a, l

	cp $E0
	jr nz, .next_cell

	ld a, h

	cp $40
	jr nz, .next_cell

	ret
