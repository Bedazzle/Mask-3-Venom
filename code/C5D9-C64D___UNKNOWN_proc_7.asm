LC5D9:
	ld a, (ix+$21)
	and a
	jr z, LC5D9_2

	ld a, (ix+$22)
	and a
	jp nz, LC6B8

	ld a, (ix+$18)
	add a, (ix+$12)
	ld (ix+$18), a

	jr z, LC5D9_0

	cp $03
	jr nz, LC5D9_1

LC5D9_0:
	ld a, (ix+$12)
	neg
	ld (ix+$12), a
LC5D9_1:
	call LC2D9
	jr nz, LC5D9_3

	call decrease_energy

	inc (ix+$11)
	ld a, (ix+$11)

	cp $05
	jr nz, LC5D9_3
LC5D9_2:
	ld (ix+$00), $00

	call LC2C1

	ld hl, LBF07	; mushroom disappearing by collision

	jp LC26F

LC5D9_3:
	call LC362_0

	cp $40
	jr c, LC5D9_5

	cp $B4
	jr nc, LC5D9_6

	dec (ix+$1C)
	ret nz

	ld a, (ix+$1B)
	neg
	ld (ix+$1B), a

	call generate_random

	and $0F
	bit 7, (ix+$1B)
	jr z, LC5D9_4

	add a, $06
LC5D9_4:
	ld (ix+$1C), a

	ret
LC5D9_5:
	ld (ix+$00), $00

	ret
LC5D9_6:
	ld (ix+$1B), $FE

	ret
