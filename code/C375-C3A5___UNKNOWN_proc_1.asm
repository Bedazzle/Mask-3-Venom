; vector 1

LC375:
	ld a, (ix+$21)
	and a
	jr z, LC375_0

	ld a, (ix+$22)
	and a
	jp nz, LC6B8

	inc (ix+$18)

	call LC362

	ld a, (ix+$04)
	add a, $30

	cp $A0
	jr nc, LC375_1

	call LC401
	jr c, LC375_1

	call LC2D9

	ret nz

	call decrease_energy

LC375_0:
	call LC2C1
LC375_1:
	ld hl, LBEFB	; sphere disappearing

	jp LC26F
