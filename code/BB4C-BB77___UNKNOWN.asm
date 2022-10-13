LBB4C:
	push af
	ld bc, LBB77 - $0100		;LBA77
	inc b
	xor a
	ld (bc), a
	ld de, LBB6B
	ld hl, LE406	; -7162 ?
	add hl, de

LBB4C_0:
	ld a, (de)

	cp (hl)
	jr nz, LBB4C_2

	and a
	jr z, LBB4C_1

	inc de
	inc hl

	jp LBB4C_0

LBB4C_1:
	ld a, $FF
	ld (bc), a

LBB4C_2:
	pop af

	ret


LBB6B:
	defb $63,$53,$12,$14,$22,$70,$12,$23
	defb $22,$12,$12,$00
LBB77:
	defb $00
