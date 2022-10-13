LC521:
	ld a, (ix+$21)
	and a
	jr z, LC521_0

	ld a, (ix+$22)
	and a
	jp nz, LC6B8

	inc (ix+$18)
	ld a, (ix+$03)
	sub $02
	ld (ix+$03), a

	cp $40
	jr c, LC521_1

	call LC2D9
	ret nz

	ld a, (ix-$26)

	cp $04
	ret nz

	ld (ix+$00), $40

	jp decrease_energy

LC521_0:
	call LC2C1
LC521_1:
	ld a, (ix-$26)

	cp $04
	jr nz, LC521_2

	ld (ix+$00), $40

	ret
LC521_2:
	ld (ix+$00), $00

	ret
