

; swap spriteset ???

LA194:
	defb $00,$01,$02,$03


swap_spritesheet:
	ld hl, LA194

	cp (hl)
	ret z

	di
	ld e, (hl)
	inc hl
	ld b, $01
swap_spritesheet_0:
	cp (hl)
	jr z, swap_spritesheet_1

	inc hl
	inc b
	jr swap_spritesheet_0

swap_spritesheet_1:
	ld d, a
	push de
	push hl
	ld hl, $5B00
	ld de, $0900	; 2304
	jr LA1B4_0

LA1B4:
	add hl, de

LA1B4_0:
	djnz LA1B4

	ld de, SPRITE_E000
	ld bc, $0800
LA1B4_1:
	ld a, (hl)		; read sprite data
	ex af, af'
	ld a, (de)
	ld (hl), a
	ex af, af'
	ld (de), a
	inc hl
	inc de
	dec bc
	ld a, b
	or c
	jp nz, LA1B4_1

	ld de, COLORS_BACKGR	; data
LA1B4_2:
	ld c, (hl)
	ex de, hl
	ld b, (hl)
	ld (hl), c
	ex de, hl
	ld (hl), b
	inc l
	inc e
	jr nz, LA1B4_2

	pop hl
	pop de
	ld (hl), e
	ld a, d
	ld (LA194), a
	ld e, a
	ld d, $00
	ld hl, LA1EC
	add hl, de
	ld a, (hl)
	ld (LC26E), a
	ei

	ret



LA1EC:
	defb $A7,$64,$56,$3F
