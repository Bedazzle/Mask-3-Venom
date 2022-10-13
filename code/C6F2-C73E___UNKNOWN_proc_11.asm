LC6F2:
	ld a, (ix+$21)
	and a
	jr z, LC71E

	ld a, (ix+$22)
	and a
	jp nz, LC6B8

	inc (ix+$18)
	ld a, (ix+$04)
	add a, $04
	ld (ix+$04), a
	add a, $30

	cp $A0
	jr nc, LC721

	call LC2D9
	jr z, LC71B

	call LC401
	ret nc

	jr LC721


LC71B:
	call decrease_energy

LC71E:
	call LC2C1

LC721:
	ld hl, LBF13		; bomber bomb dissapearing 1

	call generate_random

	rrca
	jr c, LC72D

	ld hl, LBF1F		; bomber bomb dissapearing 1

LC72D:
	call LC26F

	dec (ix+$03)
	dec (ix+$03)
	ld (ix+$1C), $02
	ld a, $0B

	jp L93DC
