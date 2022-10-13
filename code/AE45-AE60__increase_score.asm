; increase score memory buffer by value in DE

increase_score:
	push hl
	ld hl, SCORE_BUFFER+3
	ld a, e
	add a, (hl)
	daa
	ld (hl), a

	dec hl
	ld a, d
	adc a, (hl)
	daa
	ld (hl), a

	dec hl
	ld a, $00
	adc a, (hl)
	daa
	ld (hl), a

	dec hl
	ld a, $00
	adc a, (hl)
	daa
	ld (hl), a

	pop hl

	ret
