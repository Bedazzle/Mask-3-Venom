LAAA1:
	defs $C0,$00
	defb $00,$00
	defb $00,$00
	defb $00,$00
	defb $00,$00
	
LAB69:
	defb $00,$00


LAB6B:
	ld hl, LABF4
	ld a, (LA194)
	add a, a
	ld e, a
	ld d, $00
	add hl, de
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	ld (LAB6B_0+1), hl	; set SMC

	ld hl, LAAA1
	ld (LAB69), hl

	ld hl, LF0C0
	ld bc, $0240

LAB6B_0:
	ld de, $0000		; !!! SMC

LAB6B_1:
	ld a, (de)
	and a
	jr z, LAB6B_3

	cp (hl)
	jr z, LAB6B_2
	jr nc, LAB6B_3

	inc de
	jr LAB6B_1

LAB6B_2:
	ld de, (LAB69)
	ld a, l
	ld (de), a
	inc de
	ld a, h
	add a, $03
	ld (de), a
	inc de
	ld (LAB69), de

LAB6B_3:
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, LAB6B_0

	ld hl, (LAB69)
	inc hl
	ld (hl), $00

	ret
