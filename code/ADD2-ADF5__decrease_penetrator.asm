; --- decrease_penetrator ---------------------------------------
; @done
; In spriteset 2 only, walk the 4 weapon slots and decay each
; slot's Penetrator power.
decrease_penetrator:
	ld a, (SPRITESET)

	cp $02
	ret nz

	ld ix, SLOT.1
	ld de, $0004
	ld b, $04

.next_slot:
	ld a, (ix+SLOT.WEAPON)
	dec a
	jr nz, .skip

	ld (ix+SLOT.WEAPON), $00
	ld (ix+SLOT.LOAD), $00
.skip:
	add ix, de
	djnz .next_slot

	jp slot_blinking
