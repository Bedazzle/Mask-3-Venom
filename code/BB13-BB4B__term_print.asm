; terminal print, string is terminated by 7th bit set
; in: HL = string address
;   D = row, E = column

term_print:
	push hl

	call find_bmp_addr

	ex de, hl
	pop hl

	call show_cursor

	ld b, $46
print_prewait:
	halt
	djnz print_prewait

print_loop:
	ld a, (hl)

	call print_char
	call show_cursor

	ld b, $04
letter_wait:
	halt
	djnz letter_wait

	bit 7, (hl)
	inc hl
	jr z, print_loop

	ld b, $64
print_postwait:
	halt
	djnz print_postwait

	ret


show_cursor:
	ld a, $20

	call print_char

	dec e
	ld c, e
	ld a, d
	rrca
	rrca
	rrca
	and $03
	or $58
	ld b, a
	ld a, COLOR.BRIGHT + COLOR.FLASH + PAPER.BLACK + COLOR.WHITE
	ld (bc), a

	ret
