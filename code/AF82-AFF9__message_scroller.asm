message_scroller:
	ld a, (WEAPON_TEXT_LEN)
	and a
	jr nz, do_letters_scroll

	ld a, (LB0FE)
	and a
	jr z, reset_letters_scroll

	ld hl, (MESSAGE_ADDRESS)
	ld (WEAPON_TEXT), hl

	ld a, (MESSAGE_LENGTH)
	ld (WEAPON_TEXT_LEN), a

	jp message_scroller

reset_letters_scroll:
	xor a
	ld (LETTER_SCROLLER), a

	ret

do_letters_scroll:
	ld a, (LETTER_SCROLLER)
	dec a

	call z, get_next_letter

	ld (LETTER_SCROLLER), a
	ld hl, LAF14
	exx
	ld b, $06		; letter height
	ld hl, $51EB
	
loop_letters_scroll:
	ld e, l
	exx
	sla (hl)
	inc hl
	exx

	DUP 10
		rl (hl)
		dec l
	EDUP

	rl (hl)
	ld l, e
	inc h
	djnz loop_letters_scroll

	ret

get_next_letter:
	ld hl, (WEAPON_TEXT)
	ld a, (hl)
	inc hl
	ld (WEAPON_TEXT), hl

	call find_char_gfx

	ld de, BUFFER_AF15
	ld bc, $0005
	ldir				; copy letter gfx

	ld hl, WEAPON_TEXT_LEN
	dec (hl)
	ld a, $08

	ret
