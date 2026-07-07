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
