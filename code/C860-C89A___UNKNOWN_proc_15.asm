LC860:
	ld a, (ix+$21)
	and a
	jr z, LC889

	ld a, (ix+$22)
	and a
	jp nz, LC6B8

	ld a, (ix+$03)
	sub $06
	ld (ix+$03), a

	cp $34
	jr nc, LC882

	ld (ix+$00), $40
	ld (ix+$03), $00

	ret


LC882:
	call LC2D9
	ret nz

	call decrease_energy

LC889:
	call LC2C1

	ld hl, LBEFB

	call LC26F

	ld (ix+$1B), $FE
	ld (ix+$1C), $00

	ret
