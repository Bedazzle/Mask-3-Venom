; --- select_weapon_slot --------------------------------------
; @done
; Read the weapon-select keys (1-5); if one is pressed and that
; slot holds a weapon, make it the ACTIVE_SLOT, start its blink,
; and refresh the panel.
select_weapon_slot:
	ld a, (INPUT_LOCK)
	and a
	ret nz

	ld a, $F7
	in a, ($FE)
	and $0F

	cp $0F
	ret z

	push af

	call weapon_release

	pop af
	ld c, a
	ld b, $00
.count:
	inc b
	srl c
	jr c, .count

	ld hl, $0000
	ld de, $0004

	jr .mul_loop


.add_de:
	add hl, de

.mul_loop:
	djnz .add_de

	ld ix, SLOT.1
	ex de, hl
	add ix, de

	ld a, (ix+SLOT.WEAPON)
	and a
	ret z

	ld a, $06
	ld (SLOT.BLINK), a
	push ix

	call show_weapon_slot

	pop ix
	ld (ACTIVE_SLOT), ix
	ld a, (ix+SLOT.WEAPON)
