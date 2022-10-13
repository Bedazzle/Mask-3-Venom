LC562:
	ld a, (ix+$21)
	and a
	jr z, LC562_1

	ld a, (ix+$22)
	and a
	jp nz, LC6B8

	inc (ix+$11)
	ld e, (ix+$11)
	ld a, e

	cp $11
	jr nz, LC562_0

	ld (ix+$11), $FF
LC562_0:
	ld d, $00
	ld hl, LC5B5
	add hl, de
	ld a, (LAC7F)
	sub (hl)
	ld (ix+$04), a
	ld de, $0012
	add hl, de
	ld a, (hl)
	ld (ix+$18), a
	and a
	ld a, $06

	call z, L93DC

	ld a, (ix+$03)
	sub $02
	ld (ix+$03), a

	cp $40
	jr c, LC562_2

	call LC2D9
	ret nz

	call decrease_energy

LC562_1:
	call LC2C1

LC562_2:
	ld hl, LBEFB

	jp LC26F


LC5B5:
	defb $0D,$14,$1A,$1F,$24,$29,$2C,$2F
	defb $31,$32,$31,$2F,$2C,$29,$24,$1F
	defb $1A,$14,$00,$05,$05,$05,$05,$04
	defb $04,$04,$03,$03,$03,$02,$02,$02
	defb $01,$01,$01,$01
