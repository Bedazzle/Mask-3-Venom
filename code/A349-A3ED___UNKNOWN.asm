LA349:
	ld a, (ix+$19)
	and a
	ret z

	cp $01
	jp nz, LA349_5

	ld hl, SPRITE_PLAYER_D160
	ld a, (ix+$00)

	cp $08
	jr z, LA349_1
    
	cp $0A
	jr z, LA349_1
    
	cp $0C
	jr z, LA349_1
    
	ld hl, SPRITE_PLAYER_D1E0

	cp $04
	jr z, LA349_1
    
	ld hl, SPRITE_PLAYER_CDE0

	cp $07
	jr z, LA349_1
    
	ld a, (ix+$03)
	bit 7, (ix+$02)
	jr z, LA349_0
    
	neg
LA349_0:
	srl a
	srl a
	and $07
	ld h, a
	ld l, $00
	srl h
	rr l
	ld de, PLAYER_SPRITE
	add hl, de

LA349_1:
	ld (ix+$0C), l
	ld (ix+$0D), h
	ld a, (LA2CF)
	and a
	ret z

LA349_2:
	dec a
	jp z, LA349_3

	push af
	call LA349_3
	pop af

	jr LA349_2

LA349_3:
	ld l, (ix+$0C)
	ld h, (ix+$0D)
	ld de, SPRITE_DF80
	ld (ix+$0C), e
	ld (ix+$0D), d

	ld b, $20
	call generate_random

	ld r, a
	call generate_random

	ld c, a
LA349_4:

	DUP 2
		ld a, r
		add a, c
		ld c, a
		and (hl)
		inc l
		ld (de), a
		inc e
	EDUP

	ld a, r
	add a, c
	ld c, a
	and (hl)
	inc l
	ld (de), a
	inc de

	ld a, r
	add a, c
	ld c, a
	and (hl)
	inc hl
	ld (de), a
	inc de

	djnz LA349_4

	ret

LA349_5:
	add a, a
	ld (LA349_6 + 1), a     ; set SMC
	ld a, (ix+$18)
	and (ix+$1A)

LA349_6:
	jr LA349_6		; !!! SMC
