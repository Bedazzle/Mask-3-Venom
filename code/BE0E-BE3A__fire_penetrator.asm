; --- fire_penetrator: Penetrator weapon fire - start the beam dissolve + sound (@done)
fire_penetrator:
	ld a, (BLAST_ARMED)
	and a
	jr nz, fire_penetrator_0

	ld a, $FF
	ld (BLAST_ARMED), a
	ld a, $07
	call play_sfx
fire_penetrator_0:
	ld a, $02
	ld (DISSOLVE), a
	ld hl, WEAPON_AUTOFIRE
	ld a, (FRAME_PARITY)
	and $01
	add a, (hl)
	ld (hl), $00
	call consume_ammo
	ld a, (ix+SLOT.WEAPON)
	and a
	ret nz
	jp weapon_release


; fire_ultraflash (weapon 2) / fire_weapon3 (weapon 3): no projectile - just return.
fire_ultraflash:
	ret
    

fire_weapon3:
	ret
