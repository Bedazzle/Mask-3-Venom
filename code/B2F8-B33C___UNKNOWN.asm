LB2F8:
	defb $00


; Routine at B2F9
LB2F9:
	ld a, (LBB77)
	and a
	ret nz

	ld a, (LA194)

	cp $02
	call z, LB32C

	ld c, $EA
	ld a, (LA194)

	cp $03
	jr nz, LB2F9_0

	ld c, $ED

LB2F9_0:
	ld hl, (LB3E8)
	ld de, $0081
	add hl, de
	ld a, (hl)

	cp c
	jr nz, LB2F9_1

	ld a, $FF
	ld (LB2F8), a

LB2F9_1:
	inc hl
	ld a, (hl)

	cp c
	jr nz, LB2F9_2

	ld a, $FF
	ld (LB2F8), a

LB2F9_2:
	ret

LB32C:
	ld hl, (LB3E8)
	ld de, $0081
	add hl, de
	ld a, (hl)

	cp $FE
	ret c

	ld a, $FF
	ld (LB2F8), a

	ret
