LBA93:
	push af
	ld a, (LA194)
	dec a
	jr nz, LBA93_1

	ld a, (ENERGY)
	IFNDEF SAFESOME
		sub $02
	ELSE
		nop
		nop
	ENDIF
	jr nc, LBA93_0

	xor a
LBA93_0:
	ld (ENERGY), a
LBA93_1:
	pop af

	ret
