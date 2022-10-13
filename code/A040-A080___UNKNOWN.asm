LA040:
	ld hl, $57A0
	exx
	ld hl, $4000
	ld b, $58

LA040_0:
	halt
	exx

	call LA040_3

	dec h
	ld a, h
	and $07

	cp $07
	jr nz, LA040_1

	ld a, l
	sub $20
	ld l, a
	jr c, LA040_1
	ld a, h
	add a, $08
	ld h, a

LA040_1:
	exx

	call LA040_3

	inc h
	ld a, h
	and $07
	jr nz, LA040_2

	ld a, l
	add a, $20
	ld l, a
	jr c, LA040_2

	ld a, h
	sub $08
	ld h, a

LA040_2:
	djnz LA040_0

LA040_3:
	ld e, l
	ld d, $20

LA040_4:
	ld (hl), $00
	inc l
	dec d
	jr nz, LA040_4

	ld l, e

	ret
