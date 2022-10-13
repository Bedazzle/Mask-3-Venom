main_menu_loop:
	call show_main_menu
	call copy_F2F0_buff

	ld a, $FF
	ld (L970E), a
L9723_2:
	halt
	ld a, (KEMPSTON_YES)
	push af

	call LA0C9

check_kempston:
	cp "0"
	jr nz, check_sinclair

	call detect_kempston

	jr nz, check_sinclair

	xor a
	ld (KEMPSTON_YES), a
	jr control_select

check_sinclair:
	cp "1"
	jr nz, check_cursor

	ld hl, SINCLAIR_KEYS
	ld de, KEY_FIRE
	ld bc, $0005
	ldir

	ld a, $01
	ld (KEMPSTON_YES), a
	jr control_select

check_cursor:
	cp "2"
	jr nz, check_keyboard

	ld hl, CURSOR_KEYS
	ld de, KEY_FIRE
	ld bc, $0005
	ldir

	ld a, $02
	ld (KEMPSTON_YES), a
	jr control_select

check_keyboard:
	cp "3"
	jr nz, check_redefine

	ld hl, DEFINED_KEYS
	ld de, KEY_FIRE
	ld bc, $0005
	ldir

	ld a, $03
	ld (KEMPSTON_YES), a
	jr control_select

check_redefine:
	cp $62
	jr nz, L9723_8

	call redefine_keys
	call L9E10

	ld a, $03
	ld (KEMPSTON_YES), a
	ld hl, KEY_FIRE
	ld de, DEFINED_KEYS
	ld bc, $0005
	ldir

	pop af
	jp main_menu_loop

control_select:
	ld l, a
	pop af
	cp l

	call nz, show_main_menu
	jr L9723_9

L9723_8:
	pop af

L9723_9:
	ld a,"P"

	call LA090
	jp z, enter_password

	call is_fire_pressed
	bit 4, a
	jp z, L9723_2

menu_fire:
	ld a, $03
	ld (L9222), a

	call LA040

	xor a
	ld (L970E), a
	ld hl, LF600
	ld de, $1200
	ld bc, $2006

	call L99B8

	ld hl, LFC64
	ld de, $5A40
	ld bc, $00C0
	ldir

	ld de, $50E1
	ld b, $0A

L9723_10:
	ld a, $20

	call print_char
	djnz L9723_10

	xor a
	ld (WEAPON_TEXT_LEN), a
	ld (LETTER_SCROLLER), a
	ld (LB0FE), a
	ld (L970D), a

	ret

L984D:
	ld e, $F8

L984D_0:
	call L985A

	halt
	inc e
	ld a, e

	cp $3E
	jr nz, L984D_0

	ret

L985A:
	push de
	push af
	ld d, $00

L985A_0:
	push de
	ld a, $47

L985A_1:
	call col_row_to_attr

	dec e
	dec a

	cp $3F
	jp nz, L985A_1

	pop de
	dec e
	inc d
	ld a, d

	cp $18
	jr nz, L985A_0

	pop af
	pop de

	ret
