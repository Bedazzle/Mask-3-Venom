L9421:
	ld hl, (KEEP_HL_STEP_1)
	ld a, h
	or l
	jr z, L9441

	push hl
	pop iy
	ld ix, somejump_LC335-1
	ld hl, $00
	ld (KEEP_HL_STEP_1), hl

L9435:
	ld c, (iy+$0B)
	ld l, (iy+$0C)
	ld h, (iy+$0D)

	jp LC362_0-1  ;C36A


L9441:
	ld hl, (KEEP_HL_STEP_2)
	ld a, h
	or l
	jr z, L9457

	push hl
	pop iy
	ld ix, somejump_LC347-1
	ld hl, $00
	ld (KEEP_HL_STEP_2), hl

	jr L9435


L9457:
	ld hl, (KEEP_HL_STEP_3)
	ld a, h
	or l
	ret z

	push hl
	pop iy
	ld ix, somejump_LC359-1
	ld hl, $00
	ld (KEEP_HL_STEP_3), hl

	jr L9435
