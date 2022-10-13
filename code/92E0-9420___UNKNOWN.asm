PRECALCULATED:
	defb $7F,$FD,$01,$FF,$7F,$00,$00,$0F,$00,$03,$01,$1E,$06,$01
	defb $7F,$FD,$01,$FF,$7F,$02,$00,$0D,$00,$03,$01,$1E,$A8,$00
	defb $7F,$FD,$01,$FF,$7F,$02,$00,$21,$00,$03,$01,$1E,$44,$02
	defb $7F,$FD,$01,$FF,$7F,$02,$00,$03,$00,$03,$01,$1E,$44,$00
	defb $7F,$FD,$01,$FF,$7F,$02,$00,$0D,$00,$03,$01,$1E,$44,$00
	defb $7F,$FD,$01,$FF,$7F,$02,$00,$0D,$00,$03,$01,$1E,$44,$00
	defb $7F,$FB,$01,$FF,$7F,$00,$00,$EC,$FF,$01,$02,$0F,$00,$04
	defb $08,$FF,$01,$FF,$28,$FF,$00,$00,$00,$05,$01,$FF,$AC,$01
	defb $03,$81,$01,$FF,$7F,$24,$00,$F9,$FF,$02,$03,$28,$FF,$00
	defb $08,$FF,$01,$FF,$05,$00,$00,$FF,$FF,$05,$01,$82,$8C,$00
	defb $01,$FF,$01,$FF,$7F,$00,$06,$12,$00,$01,$02,$E6,$8D,$00
	defb $7F,$FF,$01,$FF,$7F,$00,$00,$FF,$FF,$02,$03,$05,$6B,$00
	defb $7F,$FE,$01,$FF,$7F,$00,$00,$FF,$FF,$02,$03,$05,$FF,$00
	defb $7F,$FF,$01,$FF,$7F,$00,$04,$14,$00,$02,$03,$05,$6B,$03
	defb $7F,$FF,$01,$FF,$7F,$00,$00,$05,$00,$03,$03,$05,$6B,$03
	defb $0A,$FF,$01,$FF,$2F,$FF,$00,$00,$00,$05,$02,$64,$EA,$03
	defb $7F,$FF,$01,$FF,$7F,$00,$00,$04,$00,$03,$01,$64,$14,$00
	defb $7F,$FF,$01,$FF,$7F,$00,$00,$04,$00,$03,$02,$64,$1E,$00


L93DC:
	push af
	push hl
	push de
	push ix
	; mult
	ld l, a
	ld e, a
	ld h, $00
	ld d, h
	add hl, hl		; x2
	add hl, de		; x3
	add hl, hl		; x6
	add hl, de		; x7
	add hl, hl		; x14
	; mult HL=A*14

	ld de, PRECALCULATED
	add hl, de		; HL = PRECALCULATED + A*14

	push hl
	pop ix
	ld a, (LFFFE)
	and a
	jr nz, L93DC_3

	ld a, (ix+$0A)

	cp $01
	jr nz, L93DC_0

	ld (KEEP_HL_STEP_1), hl
	jr L93DC_2

L93DC_0:
	cp $02
	jr nz, L93DC_1

	ld (KEEP_HL_STEP_2), hl
	jr L93DC_2

L93DC_1:
	ld (KEEP_HL_STEP_3), hl

L93DC_2:
	pop ix
	pop de
	pop hl
	pop af

	ret

L93DC_3:
	call L94AF

	jr L93DC_2


KEEP_HL_STEP_1:
	defb $00,$00
	
KEEP_HL_STEP_2:
	defb $00,$00
	
KEEP_HL_STEP_3:
	defb $00,$00
