do_snake:
	ld a, (ix+$23)
	cp $01
	ret nz

	ld a, (ix+$1F)
	and a
	jr z, LC203

	dec (ix+$1F)

	ret


LC203:
	ld a, (ALIEN.1)
	and $3F
	ret nz

	ld (ix+$1F), $32
	push ix
	ld c, $C0
	ld ix, ALIEN.1
	ld de, $0026
	ld (ix+$00), $12

	ld hl, TEMPLATE_SNAKE1

	call copy_alien_template

	ld (ix+$03), c
	ld (ix+$04), $50
	ld (ix+$11), $03
	ld (ix+$12), $00
	add ix, de
	ld a, c
	add a, $06
	ld c, a
	ld b,$04

LC239:
	ld (ix+$00), $13

	ld hl, TEMPLATE_SNAKE2

	call copy_alien_template

	ld (ix+$03), c
	ld (ix+$04), $00
	ld (ix+$1B), $00
	ld a, c
	add a, $06
	ld c, a
	add ix, de
	djnz LC239

	ld (ix+$00), $13

	ld hl, TEMPLATE_SNAKE3

	call copy_alien_template

	ld (ix+$03), c
	ld (ix+$04), $00
	ld (ix+$1B), $FF
	pop ix

	ret
