L99B8:
	push hl
	push de
	push bc
	push hl

	call find_bmp_addr ;D=row, E=column

	ld a, $20
	sub b
	ld (L99DE+1), a     ; set SMC
	ld a, b
	ld (L99B8_2+1), a   ; set SMC
	pop de

L99B8_0:
	push bc
	ld b, $04
	ld c, h

L99B8_1:
	ld a, (de)
	inc de
	ld (hl), a
	inc h
	ld a, (de)
	inc de
	ld (hl), a
	inc h
	djnz L99B8_1

	ld h, c
	inc l
	pop bc
	djnz L99B8_0

	ld a, l
	
L99DE:
	add a, $00			; !!! SMC
	ld l, a
	jr nc, L99B8_2

	ld a, h
	add a, $08
	ld h, a

L99B8_2:
	ld b, $00			; !!! SMC
	dec c
	jr nz, L99B8_0

	pop bc
	pop de
	pop hl

	ret
