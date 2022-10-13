draw_multi_logo:	; draw multicolor flag ???
					; ? Venom logo 10x7 cells
	ld bc, $021F

loop_draw_pause:
	dec bc
	ld a, b
	or c
	jr nz, loop_draw_pause

	nop
	nop
	nop
	ld de, $580B	; target in attr area
	ld hl, LF0CA
	ld a, $07

draw_multi_logo_1:
	ex af, af'
	ld a, $07
	ld c, $FF
	ld b, e

draw_multi_logo_2:
	ld e, b
	
	DUP 10		; logo width
		ldi
	EDUP

	nop
	nop
	nop
	nop
    
    dec a
	jp nz, draw_multi_logo_2

	ld a, e
	add a, $16
	ld e, a
	push de
	ld de, $000A
	add hl, de
	pop de
	ld a, $08

draw_multi_logo_3:
	dec a
	jr nz, draw_multi_logo_3

	ex af, af'
	dec a
	jr nz, draw_multi_logo_1

	xor a
	out ($FE), a

	ret
