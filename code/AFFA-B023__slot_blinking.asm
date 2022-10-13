slot_blinking:
	ld a, (SLOT.BLINK)
	push af
	xor a
	ld (SLOT.BLINK), a
	ld hl, (ACTIVE_SLOT)
	push hl
	ld hl, SLOT.1
	ld b, $04

loop_slot_blinking:
	push hl
	push bc
	ld (ACTIVE_SLOT), hl

	call show_weapon_slot

	pop bc
	pop hl
	ld de, $0004
	add hl, de
	djnz loop_slot_blinking

	pop hl
	ld (ACTIVE_SLOT), hl
	pop af
	ld (SLOT.BLINK), a

	ret
