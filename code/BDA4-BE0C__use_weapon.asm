
; --- use_weapon ----------------------------------------------
; @done
; Fire-button handler. When fire is held, dispatch on the active
; weapon (ACTIVE_SLOT.WEAPON): Penetrator/etc fire their routines,
; Healer (path below) tops up energy; each shot consumes ammo.
; The fire-released branch handles the area blast (clears cells,
; triggers death_explosion on a hit). In: ix = ACTIVE_SLOT
use_weapon:
	ld a, (KEY_FIRE_CURRENT)
	bit 4, a
	jr z, weapon_release

	ld a, (ix+SLOT.WEAPON)

	cp $01
	jp z, fire_penetrator

	cp $02
	jp z, fire_ultraflash

	cp $03
	jp z, fire_weapon3

	ld a, (ENERGY)

	cp $FF
	ret z

	add a, $02
	jr nc, .cap

	ld a, $FF
.cap:
	ld (ENERGY), a
	ld a, $01
	jp consume_ammo

weapon_release:
	ld a, (BLAST_ARMED)
	and a
	ret z

	xor a
	ld (BLAST_ARMED), a
	dec a
	ld (RESET_JUMPER_SND), a
	ld hl, (PLAYER_CELL_PTR)
	inc l
	ld de, $001F
	ld b, $03

.scan:
	call is_solid

	jr c, .blast

	inc l

	call is_solid
	jr c, .blast

	add hl, de
	djnz .scan

	jr .check_done

.blast:
	ld a, $FF
	ld (INPUT_LOCK), a

	call death_explosion
	jp lose_life_1

.check_done:
	ld a, (DISSOLVE)

	cp $02
	ret nz

	xor a
	ld (DISSOLVE), a

	ret
