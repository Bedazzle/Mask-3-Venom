; --- scan_keyboard ---------------------------------------------
; @done
; Scan the ZX keyboard matrix row by row and return the pressed
; key's row/column code.
; Out: pressed key code
scan_keyboard:
	ld b, $7F
scan_row:
	ld c, $FE
	in c, (c)
	ld a, c
	and $1F
	cp $1F
	jr nz, key_pressed

	rrc b      ; loop through 7F BF DF EF F7 FB FD FE
	jr c, scan_row

	or $FF
	ld b, a
	ret

key_pressed:
	xor a

	ret


read_keypress:
	push bc

	call scan_keyboard

	jr z, .col_loop

	pop bc

	ret

.col_loop:
	srl c
	jr nc, .row_loop

	inc a
	jr .col_loop

.row_loop:
	srl b
	jr nc, .done

	add a, $10
	jr .row_loop

.done:
	ld c, a
	xor a
	ld a, c
	pop bc

	ret


wait_keypress:
	call read_keypress

	jr z, wait_keypress

.wait:
	call read_keypress

	jr nz, .wait
	jr decode_char
