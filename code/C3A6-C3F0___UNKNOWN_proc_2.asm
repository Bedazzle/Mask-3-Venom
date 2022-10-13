LC3A6:
	ld a, (ix+$21)
	and a
	jr z, LC3A6_2

	ld a, (ix+$22)
	and a
	jp nz, LC6B8

	inc (ix+$18)
	ld a, (ix+$03)
	sub $02
	ld (ix+$03), a

	cp $28
	jr c, LC3A6_4

	ld a, (PLAYER_Y_COORD)
	add a, (ix+$11)

	cp (ix+$04)
	jr z, LC3A6_1
	jr c, LC3A6_0

	inc (ix+$04)
	jr LC3A6_1

LC3A6_0:
	dec (ix+$04)
LC3A6_1:
	call LC401
	jr c, LC3A6_3

	call LC2D9
	ret nz

	call decrease_energy

LC3A6_2:
	call LC2C1
LC3A6_3:
	ld hl, LBF07	; rocket disappearing by collision

	jp LC26F

LC3A6_4:
	ld (ix+$00), $00

	ret
