; --- show_main_menu --------------------------------------------
; @done
; Draw the menu text items from MENU_TEXTS.
show_main_menu:
	ld hl, MENU_TEXTS
	ld b, $0F
loop_menu_txt:
	ld e, (hl)		; column
	inc hl
	ld d, (hl)		; row
	inc hl

	call print_string

	djnz loop_menu_txt

	ld de, $1418

	call find_bmp_addr

	ex de, hl
	ld hl, HISCORE
	ld b, $04
.hiscore_loop:
	ld a, (hl)

	call print_A_numpair

	inc hl
	djnz .hiscore_loop

	xor a
	ld hl, MAINMENU_ICONS
.icon_loop:
	ld d, (hl)
	inc hl

	ld e, (hl)
	inc hl

	push af
	push hl
	ld hl, MENU_ICONS
	ld c, a
	ld b, $00
	add hl, bc
	ld bc, $0202
	call draw_block
	pop hl
	ld a, (hl)
	inc hl
	call col_row_to_attr
	inc e
	call col_row_to_attr
	inc d
	call col_row_to_attr
	dec e
	call col_row_to_attr
	pop af
	add a, $20
	cp $E0
	jr nz, .icon_loop
	ret


MENU_TEXTS:
	DB $18,$09
	ABYTEC 0 "PROGRAM"

	DB $18,$0A
	ABYTEC 0 "FUNGUS"

	DB $18,$0C
	ABYTEC 0 "GRAPHICS"

	DB $18,$0D
	ABYTEC 0 "MARCOS"

	DB $1B,$0E
	ABYTEC 0 "DUROE"

	DB $18,$10
	ABYTEC 0 "MUSIC"

	DB $18,$11
	ABYTEC 0 "BENN"

	DB $18,$13
	ABYTEC 0 "HISCORE"

	DB $03,$08
	ABYTEC 0 "1.KEMPSTON"

	DB $03,$0A
	ABYTEC 0 "2.INTERFACE 2"

	DB $03,$0C
	ABYTEC 0 "3.CURSOR"

	DB $03,$0E
	ABYTEC 0 "4.KEYBOARD"

	DB $03,$10
	ABYTEC 0 "K.DEFINE KEYS"

	DB $03,$12
WORD_ENTER_PASS:
	ABYTEC 0 "P.ENTER PASSWOID"	; mistyped "passwoRd"

	DB $03,$14
	ABYTEC 0 "FIRE. START GAME"
