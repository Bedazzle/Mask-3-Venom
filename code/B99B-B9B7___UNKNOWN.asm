LB99B:
	ld a, (KEY_FIRE_CURRENT)
	and $0F
	jr nz, LB9B1

	ld iy, LB9A9
	jp LB3EB_7

LB9A9:
	call LB706

	and a
	jp z, LB6E8

	ret

LB9B1:
	ld (ix+$00), $01

	jp LB3EB_1
