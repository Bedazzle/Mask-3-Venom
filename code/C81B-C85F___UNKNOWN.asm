LC81B:
	ld a, (ix+$21)
	and a
	jr z, LC856

	call generate_random

	and $25
	jr nz, LC84F

	;ld a, (ix+$DA)
	ld a, (ix-$26)
	and $3F
	jr nz, LC84F

	push ix
	ld ix, ALIEN.1
	ld (ix+$00), $0F
	ld a, (ix+$29)
	ld (ix+$03), a
	ld a, (ix+$2A)
	add a, $08
	ld (ix+$04), a

	ld hl, LBEBF
	call copy_alien_template

	pop ix

LC84F:
	call LC2D9
	ret nz

	call decrease_energy

LC856:
	ld (ix+$00), $00
	call LC2C1

	jp LC8FD
