interrupt:
	push af
	ex af, af'
	push af
	push hl
	push de
	push bc
	exx
	push hl
	push de
	push bc
	push ix
	push iy

	ld hl, L9224
	inc (hl)

	ld a, (L9225)
	out ($FE), a

	ld a, (L970E)
	and a

	call z, LBB4C
	call nz, draw_main_menu

	ld a, (LFFFE)
	and a
	jr nz, L9226_3

	ld bc, $7FFD
	ld a, $14
	out (c), a

	ld a, (L9222)
	and a
	jr z, L9226_0

	dec a

	call LBFD2_1

	xor a
	ld (L9222), a
L9226_0:
	ld a, (L9223)
	and a
	jr z, L9226_1

	call LBFD2_3

	xor a
	ld (L9223), a

L9226_1:
	call L946F
	call L9421
	call LBFD2_2

	ld a, (L970D)
	and a
	jr z, L9226_2

	ld a, (LC005 + 1)	; outside check !

	cp $FF
	ld a, $00

	call nz, LBFD2_1

L9226_2:
	ld bc, $7FFD
	ld a, $10
	out (c), a

	jr L9226_4

L9226_3:
	call L949F
	call L94C8

L9226_4:
	ld a, (L970D)
	and a

	;display "here: interrupt", $
	call z, message_scroller
	;nop
	;nop
	;nop

	ld a, (L970D)
	and a
	jr nz, L9226_5

	ld a, $7F
	in a, ($FE)

	ld l, a
	ld a, $FE
	in a, ($FE)

	or l
	bit 0, a
	jp z, diagonal_clear

L9226_5:
	pop iy
	pop ix
	pop bc
	pop de
	pop hl
	exx
	pop bc
	pop de
	pop hl
	pop af
	ex af, af'
	pop af
	ei

	ret
