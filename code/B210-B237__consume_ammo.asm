; --- consume_ammo ---------------------------------------------
; @done
; Deduct ammunition (BCD) from the active weapon slot. When the
; slot reaches zero it is emptied (WEAPON.Empty) and the weapon
; panel is refreshed via update_weapon_panel. No-op while the ammo lock CHEAT_FLAG
; is set. Caller's AF is stashed in AF' across the routine.
; In:  a = amount to deduct (BCD)
; Out: (ACTIVE_SLOT).LOAD reduced; slot emptied at zero
; Note: INFINIAMMO cheat NOPs the subtraction
consume_ammo:
	ex af, af'
	ld a, (CHEAT_FLAG)		; ammo lock
	and a
	ret nz

	ex af, af'
	ld iy, (ACTIVE_SLOT)
	push bc
	ld c, a
	ld a, (iy+SLOT.LOAD)

	IFNDEF INFINIAMMO
		sub c
	ELSE
		nop
	ENDIF

	pop bc
	daa
	ld (iy+SLOT.LOAD), a
	jr z, .empty_slot	; exactly zero -> empty

	ret nc			; still has ammo -> done

	ld (iy+SLOT.LOAD), $00	; underflow -> clamp to zero
.empty_slot:
	ld (iy+SLOT.WEAPON), $00
	ex af, af'
	xor a

	call update_weapon_panel

	ex af, af'

	ret
