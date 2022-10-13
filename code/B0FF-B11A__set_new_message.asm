set_new_message:
	ld a, $FF
	ld (CURRENT_WEAPON), a
	ld (LB0FE), a
	push hl
	xor a
loop_count_letters:
	inc a
	bit 7, (hl)
	jr nz, set_message

	inc hl
	jr loop_count_letters

set_message:
	pop hl
	ld (MESSAGE_ADDRESS), hl
	ld (MESSAGE_LENGTH), a

	jp LB0AC_2
