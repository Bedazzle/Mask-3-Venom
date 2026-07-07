; --- mark_backlash_slots --------------------------------------
; @done
; Walk the four weapon slots; flag any Backlash (weapon 8) slot
; by setting its +3 field to 3. Stops at the first empty or
; Penetrator slot.
mark_backlash_slots:
	ld ix, SLOT.1
	ld de, $0004
	ld b, $04
.next:
	ld a, (ix+SLOT.WEAPON)

	cp $08			; WEAPON.Backlash
	jr nz, .skip

	ld (ix+SLOT.POWER), $03
.skip:
	and a
	ret z			; empty slot

	cp $01
	ret z			; Penetrator

	add ix, de
	djnz .next

	ld ix, SLOT.1

	ret
