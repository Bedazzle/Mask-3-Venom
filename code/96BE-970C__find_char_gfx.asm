find_char_gfx:
	and $7F
	
	cp "a"		;$61
	jr c, check_letter

	cp "{"		; z+1	$7B
	jr nc, check_letter

	sub $20
check_letter:
	cp "A"		;$41
	jr c, check_digit

	cp "["		; Z+1	$5B
	jr nc, check_digit

	sub $41
	ld bc, FONT_CHARS
	jr finish_char

check_digit:
	cp "0"		;$30
	jr c, check_dot

	cp ":"		;9+1	$3A
	jr nc, check_dot

	sub $30
	ld bc, FONT_DIGITS
	jr finish_char

check_dot:
	cp "."		;$2E
	jr nz, check_colon

	ld bc, FONT_SYMBOLS ;FONT_DOT
	xor a
	jr finish_char

check_colon:
	cp ":"		;$3A
	jr nz, check_space

	xor a
	ld bc, FONT_COLON
	jr finish_char

check_space:
	cp " "		;$20
	ret nz

	xor a
	ld bc, FONT_SPACE
finish_char:
	; mult
	ld l, a
	add a, a
	add a, a
	add a, l
	ld l, a
	; mult L = L*5

	ld h, $00
	add hl, bc
	xor a

	ret
