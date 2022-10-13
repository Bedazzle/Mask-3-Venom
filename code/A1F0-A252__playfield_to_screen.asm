playfield_to_screen:
	ld a, $FF
	ld (LF3BF), a
	ld hl, LF600
	
	ld ix, draw_loop
	
draw_loop:
	xor a
	dec hl

skip_zeroes:
	or (hl)
	dec hl
	jp z, skip_zeroes ; optimize to JR

	ret M

	dec a
	inc hl
	ld (hl), a
	push hl
	dec h
	dec h
	dec h
	ld e, (hl)
	add a, $FC
	ld d, a

	ld bc, $FF40	; -192 dec
	add hl, bc
	ld c, e
	ld b, h

	ld a, h
	and $03
	add a, a
	add a, a
	add a, a
	add a, $40
	ld h, a

	ex de, hl
	add hl, hl
	add hl, hl
	add hl, hl

	; -----------
	; cell to screen
	DUP 7
		ld a, (hl)		; get sprite byte
		ld (de), a		; put to screen
		inc d			; down DE
		inc l			; next sprite byte
	EDUP

	ld a, (hl)
	ld (de), a
	; -----------

	ld a, b
	sub $98
	ld d, a		; DE = attr area

	ld b, high COLORS_BACKGR
	bit 3, h
	jr z, get_attribute

	ld b, high COLORS_PLAYER

get_attribute:
	ld a, (bc)
	and $47			; 01 000 111   no flash/bright/black paper + defined ink
	ld (de), a		; set attributes on screen
	pop hl

	jp (ix)
