LC89B:
	ld a, (ix+$21)
	and a
	jr z, LC8FA

	ld a, (ix+$03)
	sub $02
	ld (ix+$03), a

	cp $DC
	ld a, $0A

	call z, L93DC
	call generate_random

	and $92
	jr nz, LC8F3

	ld h, (ix+$04)
	ld l, (ix+$03)
	ld a, l
	sub $40
	jp m, LC8F3

	push ix
	ld ix, ALIEN.1
	ld de, $26
	ld b, 6

LC8CE:
	ld a, (ix+$00)
	and $3F
	jr z, LC8DB

	add ix, de
	djnz LC8CE

	jr LC8F1


LC8DB:
	ld (ix+$00), $0B
	ld a, h
	add a, $08
	ld (ix+$04), a
	ld a, l
	add a, $04
	ld (ix+$03), a

	ld hl, LBE8F		; bomber bomb
	call copy_alien_template

LC8F1:
	pop ix

LC8F3:
	call LC2D9
	ret nz

	call decrease_energy

LC8FA:
	call LC2C1

LC8FD:
	ld a, (ix+$03)
	ld (ix+$11), a
	ld a, (ix+$04)
	ld (ix+$12), a
	ld (ix+$00), $11
	ld (ix+$03), $00
	ld (ix+$05), $01
	ld (ix+$06), $01
	ld (ix+$19), $06
	ld (ix+$10), $19

	ret
