RND:
	defb $00,$00,$00

generate_random:
	push hl
	push de
	ld hl, RND
	ld a, (hl)
	add a, $2D
	rrca
	ld (hl), a

	ld e, a
	inc hl
	ld a, (hl)
	sub $8D
	ld (hl), a

	add a, e
	inc hl
	rlca
	rrc (hl)
	add a, (hl)
	ld (hl), a

	pop de
	pop hl

	ret
