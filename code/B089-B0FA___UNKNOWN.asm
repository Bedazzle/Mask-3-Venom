LB089:
	ld a, (LBAA7)
	and a
	ret nz

	ld a, $F7
	in a, ($FE)
	and $0F

	cp $0F
	ret z

	push af

	call LBDA4_1

	pop af
	ld c, a
	ld b, $00
LB089_0:
	inc b
	srl c
	jr c, LB089_0

	ld hl, $0000
	ld de, $0004

	jr LB0AC_0


LB0AC:
	add hl, de

LB0AC_0:
	djnz LB0AC

	ld ix, SLOT.1
	ex de, hl
	add ix, de

	ld a, (ix+$01)
	and a
	ret z

	ld a, $06
	ld (SLOT.BLINK), a
	push ix

	call show_weapon_slot

	pop ix
	ld (ACTIVE_SLOT), ix
	ld a, (ix+$01)

LB0CE:
	ld hl, CURRENT_WEAPON

	cp (hl)
	ret z

	ld (CURRENT_WEAPON), a

	; muliplication
	ld h, $00
	ld l, a
	ld d, h
	ld e, l
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, de	; x5
	add hl, hl	; x10
	add hl, de	; x11
	; HL = A*11		11 is a weapon text length

	ld de, WEAPONS
	add hl, de		; HL=weapon text addr

	xor a
	ld (LB0FE), a
	ld a, $0C

LB0AC_2:
	ld (WEAPON_TEXT), hl
	ld (WEAPON_TEXT_LEN), a
	ld a, (LETTER_SCROLLER)
	and a
	ret nz

	ld a, $01
	ld (LETTER_SCROLLER), a
	
	ret
