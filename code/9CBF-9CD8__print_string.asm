print_string:
	push bc
	push de
	push hl

	call find_bmp_addr

	pop bc
	ex de, hl
print_str_loop:
	ld a, (bc)

	call print_char

	ld a, (bc)
	and $80
	jr nz, last_char

	inc bc
	jr print_str_loop

last_char:
	pop de
	inc bc
	ld h, b
	ld l, c
	pop bc

	ret
