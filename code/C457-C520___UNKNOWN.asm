LC457:
	ld a, (ix+$21)
	and a
	jp z, LC457_6

	ld a, (ix+$18)

	cp $03
	jr z, LC457_0

	ld a, (LCC5C)
	rrca
	ret c

	inc (ix+$18)

	ret
	
LC457_0:
	inc (ix+$1C)
	bit 4, (ix+$1C)
	jr z, LC457_1

	inc (ix+$04)
	jr LC457_2

LC457_1:
	dec (ix+$04)
LC457_2:
	call LC503

	ld (hl), $00
	ld de, $0020
	add hl, de
	ld a, (LC26E)
	ld (hl), a

	call generate_random

	and $53
	jr z, LC457_3

	call LC2D9
	ret nz

	call decrease_energy

	jp LC457_6

LC457_3:
	ld b, (ix+$04)
	ld c, (ix+$03)
	ld de, $0026
	ld a, (ix+$26)

	cp $40
	jr z, LC457_4

	ld a, (ix+$4C)
	and $3F
	ret nz

	ld (ix+$18), $00
	add ix, de
	add ix, de
	jr LC457_5

LC457_4:
	ld (ix+$18), $00
	add ix, de
LC457_5:
	ld (ix+$00), $05
	ld a, c
	ld (ix+$03), a
	ld a, b
	add a, $04
	ld (ix+$04), a

	ld hl, TEMPLATE_ROUND
	jp copy_alien_template

LC457_6:
	ld l, (ix+$11)
	ld h, (ix+$12)
	ld (hl), CANNON_KILL	; cannon destroyed

	ld hl, LBF07			; cannon disappearing

	call LC26F
	call LC503

	ld de, $0020
	ld a, (LC26E)
	ld b, a
LC457_7:
	add hl, de
	ld a, (hl)
	and a
	jr z, LC457_7

	cp b
	jp nz, LC2C1

	ld (hl), $00
	ld c, h
	inc h
	inc h
	inc h
	ld (hl), $01
	ld h, c

	jr LC457_7


LC503:
	ld a, (ix+$04)
	add a, $04
	and $F8
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld a, (ix+$03)
	sub $40
	srl a
	srl a
	ld e, a
	ld d, $00
	add hl, de
	ld de, LF0C1
	add hl, de

	ret
