show_slot_box:
	push af
	push hl
	ex de, hl
	ld h, $00
	ld l, a
	ld a, (SLOT.BLINK)
	bit 3, a
	jr z, slot_show
	
slot_hide:
	ld l, h
slot_show:
	; mult
	add hl, hl		; x2
	add hl, hl		; x4
	add hl, hl		; x8
	add hl, hl		; x16
	add hl, hl		; x32
	; mult HL = HL*32
	ld bc, SPRITE_WEAPON
	add hl, bc
	ld b, $02

show_slot_box_1:
	ld c, $02
	push de

show_slot_box_2:
	; -----
	DUP 7
		ld a, (hl)
		inc hl
		ld (de), a
		inc d
	EDUP

	ld a, (hl)
	inc hl
	ld (de), a
	ld a, d
	; -----

	sub $07
	ld d, a
	ld a, e
	add a, $20
	ld e, a
	dec c
	jp nz, show_slot_box_2

	pop de
	inc e
	djnz show_slot_box_1

	pop hl
	pop af
	ld h, $5A
	add a, $46
	ld e, a
	ld a, $00
	add a, $AF
	ld d, a
	ld a, (de)
	or $40
	ld (hl), a
	inc l
	ld (hl), a
	ld de, $001F
	add hl, de
	ld (hl), a
	inc l
	ld (hl), a

	ret
