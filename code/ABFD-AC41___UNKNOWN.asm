LABFD:
	ld (LABFC), a
	ld hl, (ROOM_BACKGR_ADDR)
	ld de, $0028
	ld bc, $0805

LABFD_0:
	cp (hl)
	jr z, LABFD_1

	inc hl
	djnz LABFD_0

	add hl, de
	ld b, $08
	dec c
	jr nz, LABFD_0

	ret


LABFD_1:
	push bc
	exx
	pop bc
	ld a, $08
	sub b
	rlca
	rlca
	rlca
	rlca
	add a, $40
	ld b, a
	ld a, $05
	sub c
	rrca
	rrca
	rrca
	sub $10
	ld c, a
	or $FF

	ret


LAC2F:
	ld a, (LABFC)
	exx
	jr LAC35_0


LAC35:
	cp (hl)
	jr z, LABFD_1

LAC35_0:
	inc hl
	djnz LAC35

	add hl, de
	ld b, $08
	dec c
	jr nz, LAC35

	ret
