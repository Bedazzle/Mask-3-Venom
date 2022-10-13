prepare_multicolor:
	ld hl, BUFF_F2F0+1
	ld de, BUFF_F2F0
	ld bc, $004B	; 75
	ldir			; ? Venom strikes back logo 10x7 cells

	ld hl, (CURRENT_MULTIADDR)
	ld a, (hl)

	cp $FF
	jr nz, same_multicolor

	call generate_random

	and $07
	add a, a	; x2
	ld l, a
	ld h, $00
	ld bc, MULTICOLORS
	add hl, bc
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	ld a, (hl)
same_multicolor:
	or $40			; 0100 0000
	ld (de), a

	call generate_random

	cp $8C		; width of multicor stripes
	jr c, set_multicolor_adr

	inc hl
set_multicolor_adr:
	ld (CURRENT_MULTIADDR), hl

	ret
