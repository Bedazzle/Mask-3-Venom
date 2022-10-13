LB5FD:
	ld a, (PLAYER_X_COORD)
	sub $3C			; 60
	rrca
	rrca
	and $1F
	ld e, a
	ld d, $00
	ld a, (PLAYER_Y_COORD)
	and $F8

	ld l, a
	ld h, d
	add hl, hl		; x2
	add hl, hl		; x4
	add hl, de
	ld de, LF0C0-1	;LF0BF
	add hl, de

	ld (LB3E8), hl
	bit 7, (ix+$02)
	jr nz, LB5FD_0

	ld de, $0003
	add hl, de

LB5FD_0:
	ld (LB3E6), hl
	ld a, (hl)

	ret
