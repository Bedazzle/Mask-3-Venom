LC922:
	dec (ix+$10)
	jr nz, LC92C

	ld (ix+$00), $00

	ret

LC92C:
	call generate_random

	and $0F
	sub $02
	add a, (ix+$11)
	ld l, a

	call generate_random

	and $0F
	sub $04
	add a, (ix+$12)
	ld h, a
	ld ix, ALIEN.1
	ld de, $26
	ld b,$06

LC94B:
	ld a, (ix+$00)
	and $3F
	jr z, LC957

	add ix, de
	djnz LC94B

	ret


LC957:
	ld (ix+$03), l
	ld (ix+$04), h

	call generate_random

	and $03
	bit $01, a
	jr z, LC973

	ld hl, LBEFB
	bit $00, a
	jr z, LC970

	ld hl, LBF07

LC970:
	jp LC26F


LC973:
	ld hl, LBF13
	bit $00, a
	jr z, LC97D

	ld hl, LBF1F

LC97D:
	jp LC26F
