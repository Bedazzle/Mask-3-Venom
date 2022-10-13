print_char:
	push bc
	push hl

	call find_char_gfx

	jr nz, print_char_end

	ld c, d
	ld b, $05
	xor a
	ld (de), a
	inc d
	ld (de), a
	inc d

copy_char:
	ld a, (hl)
	inc hl
	ld (de), a
	inc d
	djnz copy_char

	xor a
	ld (de), a
	ld d, c
	ld l, e
	ld a, d
	rrca
	rrca
	rrca
	and $03
	or $58
	ld h, a
	ld (hl), $47
	inc e

print_char_end:
	pop hl
	pop bc

	ret
