LB210:
	ex af, af'
	ld a, (LBB77)
	and a
	ret nz

	ex af, af'
	ld iy, (ACTIVE_SLOT)
	push bc
	ld c, a
	ld a, (iy+SLOT.LOAD)

	IFNDEF INFINIAMMO
		sub c
	ELSE
		nop
	ENDIF

	pop bc
	daa
	ld (iy+SLOT.LOAD), a
	jr z, LB210_0

	ret nc

	ld (iy+SLOT.LOAD), $00

LB210_0:
	ld (iy+SLOT.WEAPON), $00
	ex af, af'
	xor a

	call LB0CE

	ex af, af'

	ret
