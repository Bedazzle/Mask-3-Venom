WEAPON_FLASH_TIMER:
	DB $00

; --- tick_active_weapon --------------------------------------
; @done
; Per-frame effect of the active weapon: UltraFlash (2) strobes
; the border and drains ammo; Healer (4) regenerates energy and
; drains ammo every 4th frame. In: (ACTIVE_SLOT)
; Note: no direct caller found.
tick_active_weapon:
	ld ix, (ACTIVE_SLOT)
	ld a, (ix+SLOT.WEAPON)
	and a
	ret z
	
	cp $02
	jr nz,.healer

	ld a, (WEAPON_FLASH_TIMER)
	and a
	ret z

	dec a
	ld (WEAPON_FLASH_TIMER),a
	bit 0,a
	ld a,$00
	jr nz, .set_border

	ld a,$07
.set_border:
	ld (BORDER_VALUE),a
	ld a,$01

	call consume_ammo

	ret

.healer:
	cp $04
	ret nz

	ld a, (ENERGY)

	cp $FF
	ret z

	inc a
	ld (ENERGY), a
	and $03
	ret nz

	ld a, $01

	call consume_ammo

	ret
