LB238:
	defb $00

LB239:
	ld ix, (ACTIVE_SLOT)
	ld a, (ix+$01)
	and a
	ret z
	
	cp $02
	jr nz,LB260

	ld a, (LB238)
	and a
	ret z

	dec a
	ld (LB238),a
	bit 0,a
	ld a,$00
	jr nz, LB257

	ld a,$07
LB257:
	ld (L9225),a
	ld a,$01

	call LB210

	ret

LB260:
	cp $04
	ret nz

	ld a, (ENERGY)

	cp $FF
	ret z

	inc a
	ld (ENERGY), a
	and $03
	ret nz

	ld a, $01

	call LB210

	ret
