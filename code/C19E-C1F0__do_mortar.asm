do_mortar:
	ld a, (ix+$1F)
	and a
	jp nz, LBF2B_1

	push ix

	call kill_all_aliens

	ld ix, ALIEN.1
	ld (ix+$00), $80
	ld (ix+$05), $02
	ld (ix+$06), $02
	ld (ix+$03), $01

	ld ix, ALIEN.2
	ld (ix+$03), $A4
	ld hl, LF0D9
	ld c,$00
	ld de, $20

LC1CE:
	call LB993

	jr c, LC1D7

	add hl, de
	inc c
	jr LC1CE

LC1D7:
	ld a, c
	add a, a
	add a, a
	add a, a
	sub $20
	ld (ix+$04), a
	ld (ix+$00), $0E
	ld (ix+$1F), $FF

	ld hl, TEMPLATE_MORTAR

	call copy_alien_template

	pop ix

	ret
