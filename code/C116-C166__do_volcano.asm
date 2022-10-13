do_volcano:
	ld de, (LAC9C)
	ld hl, (LAC9E)
	ld a, d
	or e
	ret z

	ld a, h
	or l
	jr z, LC12B

	call generate_random

	rrca
	jr c, LC12B

	ex de, hl

LC12B:
	ld (ix+$00), $0C

	ld hl, TEMPLATE_VOLCANO

	call copy_alien_template

	ld a, e
	add a, $0A
	ld (ix+$04), a

	call generate_random

	and $07
	add a, d
	ld (ix+$03), a
	sub d
	sub $04
	ld (ix+$1B), a

	call generate_random

	and $07
	add a, $05
	neg
	ld (ix+$1C), a

	call generate_random

	rrca
	ld (ix+$02), a
	ld a, $01
	jr c, LC163

	ld a, $FF

LC163:
	ld (ix+$11), a

	ret
