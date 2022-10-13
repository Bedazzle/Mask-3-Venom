LC73F:
	ld a, (ix+$21)
	and a
	jr z, LC780

	ld a, (ix+$22)
	and a
	jp nz, LC6B8

	ld a, (ix+$18)
	add a, (ix+$11)
	ld (ix+$18), a

	call LC362_0

	cp $30
	jr c, LC783

	cp $C0
	jr nc, LC783

	ld a, (ix+$04)
	add a, (ix+$1C)
	ld (ix+$04), a
	inc (ix+$1C)
	add a, $20

	cp $86
	jr nc, LC783

	call LC2D9
	jr z, LC77D

	call LC401
	jr c, LC783

	ret


LC77D:
	call decrease_energy

LC780:
	call LC2C1

LC783:
	ld hl, LBEFB

	jp LC26F
