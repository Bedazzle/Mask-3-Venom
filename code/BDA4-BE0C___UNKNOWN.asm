
; ??? heal ???

LBDA4:
	ld a, (KEY_FIRE_CURRENT)
	bit 4, a
	jr z, LBDA4_1

	ld a, (ix+$01)

	cp $01
	jp z, LBE0E

	cp $02
	jp z, LBE39

	cp $03
	jp z, LBE3A

	ld a, (ENERGY)

	cp $FF
	ret z

	add a, $02
	jr nc, LBDA4_0

	ld a, $FF
LBDA4_0:
	ld (ENERGY), a
	ld a, $01
	jp LB210

LBDA4_1:
	ld a, (LB3EA)
	and a
	ret z

	xor a
	ld (LB3EA), a
	dec a
	ld (L946C), a
	ld hl, (LB3E8)
	inc l
	ld de, $001F
	ld b, $03

LBDA4_2:
	call LB993

	jr c, LBDA4_3

	inc l

	call LB993
	jr c, LBDA4_3

	add hl, de
	djnz LBDA4_2

	jr LBDA4_4

LBDA4_3:
	ld a, $FF
	ld (LBAA7), a

	call LBB78
	jp LBAA8_1

LBDA4_4:
	ld a, (LA2CF)

	cp $02
	ret nz

	xor a
	ld (LA2CF), a

	ret
