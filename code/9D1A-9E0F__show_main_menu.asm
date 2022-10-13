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
L9D1A_1:
	ld a, (hl)

	call print_A_numpair

	inc hl
	djnz L9D1A_1

	xor a
	ld hl, MAINMENU_ICONS
L9D1A_2:
	ld d, (hl)
	inc hl

	ld e, (hl)
	inc hl

	push af
	push hl
	ld hl, LCC80
	ld c, a
	ld b, $00
	add hl, bc
	ld bc, $0202
	call L99B8
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
	jr nz, L9D1A_2
	ret


MENU_TEXTS:
	defb $18,$09
	ABYTEC 0 "PROGRAM"

	defb $18,$0A
	ABYTEC 0 "FUNGUS"

	defb $18,$0C
	ABYTEC 0 "GRAPHICS"

	defb $18,$0D
	ABYTEC 0 "MARCOS"

	defb $1B,$0E
	ABYTEC 0 "DUROE"

	defb $18,$10
	ABYTEC 0 "MUSIC"

	defb $18,$11
	ABYTEC 0 "BENN"

	defb $18,$13
	ABYTEC 0 "HISCORE"

	defb $03,$08
	ABYTEC 0 "1.KEMPSTON"

	defb $03,$0A
	ABYTEC 0 "2.INTERFACE 2"

	defb $03,$0C
	ABYTEC 0 "3.CURSOR"

	defb $03,$0E
	ABYTEC 0 "4.KEYBOARD"

	defb $03,$10
	ABYTEC 0 "K.DEFINE KEYS"

	defb $03,$12
WORD_ENTER_PASS:
	ABYTEC 0 "P.ENTER PASSWOID"	; mistyped "passwoRd"

	defb $03,$14
	ABYTEC 0 "FIRE. START GAME"
