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


LA0C9:
	push bc

	call scan_keyboard

	jr z, LA0C9_0

	pop bc

	ret

LA0C9_0:
	srl c
	jr nc, LA0C9_1

	inc a
	jr LA0C9_0

LA0C9_1:
	srl b
	jr nc, LA0C9_2

	add a, $10
	jr LA0C9_1

LA0C9_2:
	ld c, a
	xor a
	ld a, c
	pop bc

	ret


LA0E5:
	call LA0C9

	jr z, LA0E5

LA0E5_0:
	call LA0C9

	jr nz, LA0E5_0
	jr decode_char
