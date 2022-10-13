startup:
	di
	ld hl, DATA_BLOCK1
	ld de, $5B00
	ld bc, $0500
	ldir

	ld hl, COLORS_PLAYER
	ld de, L6300
	ld bc, $0100
	ldir

	ld a, $FF
	ld r, a
	ld sp,STACK
	ld a, high INT_VECTORS	; $FE
	ld i, a
	ld hl, INT_VECTORS		; $FE00
	ld de, INT_VECTORS+1	; $FE01
	ld bc, $0100
	ld (hl), $FF
	ldir

	ld a, $18				; opcode "JR"
	ld (last_jump), a

	ld a, $C3				; opcode "JP"
	ld (to_interrupt), a

	ld hl, interrupt
	ld (to_interrupt+1), hl

	im 2
	xor a
	ld (COLORS_BACKGR), a
	ld (L6300), a
	ld (L6C00), a
	ld (L7500), a

	call detect_kempston

	jp nz, diagonal_clear

	xor a
	ld (KEMPSTON_YES), a

	jp diagonal_clear
