LC980:
	ld a, (ix+$22)
	and a
	jr z, LC98E

	call LC6B8

	ld (ix+$1B), $FF

	ret

LC98E:
	ld a, (ix+$04)
	ld (ix+$1C), a
	inc (ix+$11)
	bit 3, (ix+$11)
	jr z, LC9A2

	inc (ix+$12)
	jr LC9A5


LC9A2:
	dec (ix+$12)

LC9A5:
	ld a, (ix+$04)
	add a, (ix+$12)
	ld (ix+$04), a
	dec (ix+$03)

	call LC2D9
	jp z, decrease_energy

	ret
