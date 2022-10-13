LAC9C:
	defb $00,$00
LAC9E:
	defb $00,$00


LACA0:
	ld hl, $0000
	ld (LAC9C), hl
	ld (LAC9E), hl
	ld a, $61

	call LABFD
	ret z

	ld (LAC9C), bc

	call LAC2F
	ret z

	ld (LAC9E), bc

	ret
