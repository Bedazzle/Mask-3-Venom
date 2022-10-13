LA3F2:
	jr LA3FE

LA3F4:
	jr LA3FE

LA3F6:
	jr LA407

LA3F8:
	jr LA40C

LA3FA:
	jr LA411

LA3FC:
	jr LA414


LA3FE:
	;mult
	ld l, a
	add a, a	; x2
	add a, l	; x3
	add a, a	; x6
	add a, a	; x12
	add a, a	; x24
	add a, a	; x48
	;mult A=A*48
	jr LA422

LA407:
	rrca
	rrca
	rrca
	jr LA422

LA40C:
	;mult
	add a, a
	add a, a
	add a, a
	; mult A=A*8
	jr LA422

LA411:
	xor a
	jr LA422

LA414:
	;mult
	add a, a
	add a, a
	add a, a
	ld l, a
	ld h, $00
	ld e, a
	ld d, h
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	;mult HL=A*72
	jr LA431

LA422:
	add a, (ix+$16)
	ld (ix+$0C), a
	ld a, $00
	adc a, (ix+$17)
	ld (ix+$0D), a

	ret

LA431:
	ld e, (ix+$16)
	ld d, (ix+$17)
	add hl, de
	ld (ix+$0C), l
	ld (ix+$0D), h

	ret
