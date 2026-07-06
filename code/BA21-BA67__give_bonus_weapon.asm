; --- give_bonus_weapon ----------------------------------------
; @done
; Award the Lifter (WEAPON.Lifter=6) with a full 99 (BCD) load in
; slot 1, refresh the panel and start its blink. Called on
; reaching the 4th teleporter.
give_bonus_weapon:
	ld ix, SLOT.1
	ld a, (ix+SLOT.WEAPON)
	and a

	call z, refresh_weapon_panel
	call mark_backlash_slots

	ld (ix+SLOT.WEAPON), $06		; WEAPON.Lifter
	ld (ix+SLOT.LOAD), $99		; load = 99 (BCD)
	ld (ix+SLOT.POWER), $01

	jp slot_blinking


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


; --- refresh_weapon_panel -------------------------------------
; @done
; Repaint the weapon panel (slot 6 row) via update_weapon_panel.
refresh_weapon_panel:
	push af
	ld a, $06

	call update_weapon_panel

	pop af

	ret
