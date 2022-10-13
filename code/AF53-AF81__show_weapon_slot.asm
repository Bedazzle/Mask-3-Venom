show_weapon_slot:
	ld ix, (ACTIVE_SLOT)

	ld h, $50
	ld l, (ix + SLOT.XPOS)
	push hl
	ld a, (ix + SLOT.WEAPON)

	call show_slot_box

	pop de
	ld a, e
	add a, $40
	ld e, a

	ld a, (ix + SLOT.LOAD)

print_A_numpair:
	push af
	rrca
	rrca
	rrca
	rrca				; A = upper nibble

	call print_A_number

	pop af

print_A_number:
	and $0F				; A = lower nibble
	add a, '0'

	cp '9' + 1			; ":" symbol
	jp c, print_char	; optimize jr c to end of procedure

	add a, 'A' - ':'		; $07 convert to letters A-Z

	jp print_char
