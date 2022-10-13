LB9D8:
	ld a, (ix+$10)
	and $0F
	jr nz, LB9D8_0

	ld hl, LA2CF
	inc (hl)
LB9D8_0:
	dec (ix+$10)
	ret nz

	ld a, (ix+$03)
	sub $40
	rlca
	rlca
	rlca
	and $03
	ld e, a
	ld d, $00
	ld hl, LBA1D
	add hl, de
	ld a, (hl)
	ld (LEVEL_NUMBER), a
	xor a
	ld (ROOM_NUMBER), a		; teleported
	ld (ix+$03), $42
	ld a, (ix+$04)
	add a, $08
	ld (ix+$04), a
	ld (ix+$00), $08
	xor a
	ld (LA2CF), a
	ld a, e

	cp $03
	call z, LBA21

	jp LA89D


LBA1D:
	defb $0B,$03,$07,$07
