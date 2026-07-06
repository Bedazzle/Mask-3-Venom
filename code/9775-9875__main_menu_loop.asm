; --- main_menu_loop --------------------------------------------
; @done
; The main-menu input loop: draw the menu, poll the controls, and
; act on the selection (start / redefine keys / password).
main_menu_loop:
	call show_main_menu
	call copy_F2F0_buff

	ld a, $FF
	ld (IN_MENU), a
menu_recheck:
	halt
	ld a, (KEMPSTON_YES)
	push af

	call read_keypress

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
	jr nz, menu_keep

	call redefine_keys
	call clear_screen_pixels

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
	jr menu_check_p

menu_keep:
	pop af

menu_check_p:
	ld a,"P"

	call read_key
	jp z, enter_password

	call is_fire_pressed
	bit 4, a
	jp z, menu_recheck

menu_fire:
	ld a, $03
	ld (SND_TRIG_1), a

	call wipe_screen

	xor a
	ld (IN_MENU), a
	ld hl, MIRROR_LUT
	ld de, $1200
	ld bc, $2006

	call draw_block

	ld hl, COLOR_LUT2
	ld de, $5A40
	ld bc, $00C0
	ldir

	ld de, $50E1
	ld b, $0A

.space_loop:
	ld a, $20

	call print_char
	djnz .space_loop

	xor a
	ld (WEAPON_TEXT_LEN), a
	ld (LETTER_SCROLLER), a
	ld (WEAPON_PANEL_FLAG), a
	ld (HUD_ACTIVE), a

	ret

menu_wipe_in:
	ld e, $F8

.loop:
	call draw_diagonal_attrs

	halt
	inc e
	ld a, e

	cp $3E
	jr nz, .loop

	ret

draw_diagonal_attrs:
	push de
	push af
	ld d, $00

.row:
	push de
	ld a, $47

.col:
	call col_row_to_attr

	dec e
	dec a

	cp $3F
	jp nz, .col

	pop de
	dec e
	inc d
	ld a, d

	cp $18
	jr nz, .row

	pop af
	pop de

	ret
