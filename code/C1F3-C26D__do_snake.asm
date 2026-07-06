; --- do_snake --------------------------------------------------
; @done
; Spawn the snake when the arena is clear: a head (SNAKE1) plus 4
; body segments (SNAKE2) and a tail (SNAKE3), chained across x.
; In: ix = alien slot
do_snake:
	ld a, (ix+ALIEN.index)
	cp $01
	ret nz

	ld a, (ix+ALIEN.spawn)
	and a
	jr z, .spawn

	dec (ix+ALIEN.spawn)

	ret


.spawn:
	ld a, (ALIEN.1)
	and $3F
	ret nz

	ld (ix+ALIEN.spawn), $32
	push ix
	ld c, $C0
	ld ix, ALIEN.1
	ld de, ALIEN_LEN
	ld (ix+ALIEN.state), $12

	ld hl, TEMPLATE_SNAKE1

	call copy_alien_template

	ld (ix+ALIEN.x), c
	ld (ix+ALIEN.y), $50
	ld (ix+ALIEN.param1), $03
	ld (ix+ALIEN.param2), $00
	add ix, de
	ld a, c
	add a, $06
	ld c, a
	ld b,$04

.body_loop:
	ld (ix+ALIEN.state), $13

	ld hl, TEMPLATE_SNAKE2

	call copy_alien_template

	ld (ix+ALIEN.x), c
	ld (ix+ALIEN.y), $00
	ld (ix+ALIEN.xvel), $00
	ld a, c
	add a, $06
	ld c, a
	add ix, de
	djnz .body_loop

	ld (ix+ALIEN.state), $13

	ld hl, TEMPLATE_SNAKE3

	call copy_alien_template

	ld (ix+ALIEN.x), c
	ld (ix+ALIEN.y), $00
	ld (ix+ALIEN.xvel), $FF
	pop ix

	ret
