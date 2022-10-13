	device zxspectrum48

; sp 24576
;STARTGAME	EQU startup	; 9100	; 37120

	include "mask_3_constants.asm"


	ORG $6000

STARTBLOCK:
	include "data/sprites_6000-60FF.asm"
	include "data/sprites_6100-61FF.asm"
	include "data/sprites_6200-62FF.asm"
	
	include "data/data_6300-75FF.asm"
	include "data/rooms_7600-84FF.asm"
	include "data/backgr_tiles_8500-90FF.asm"

	include "code/9100-915A__startup.asm"
	include "code/915B-9207__new_game.asm"
	include "code/9208-920F__deadly_loop.asm"
	include "code/9210-9221__striped_border.asm"


L9222:
	defb $00
L9223:
	defb $FF
L9224:
	defb $00
	
L9225:
	defb $00

	include "code/9226-92C2__interrupt.asm"
	include "code/92C3-92DF__generate_random.asm"

	include "code/92E0-9420___UNKNOWN.asm"
	include "code/9421-946B___UNKNOWN.asm"


L946C:
	db $00
L946D:
	db $00
L946E:
	db $00


	include "code/946F-949E___UNKNOWN.asm"


; Routine at 949F
L949F:
	ld hl, L946C
	ld a, (hl)
	and a
	ret z
	xor a
	ld (L94AB), a
	ld (hl), a
	ret


L94AB:
	defb $00,$00,$00,$00


L94AF:
	ld (L94AB+3), ix
	ld a, (ix+$0B)
	ld (L94AB), a
	ld l, (ix+$0C)
	ld h, (ix+$0D)
	ld (L94AB+1), hl
	ret


L94C3:
	xor a
	ld (L94AB), a

	ret


	include "code/94C8-9509___UNKNOWN.asm"


LEVEL_NUMBER:
	defb $00
	
ROOM_EXITS_ADDR:
	defb $00,$00
	
ROOM_NUMBER:
	defb $00

BOXES:
	;    Lvl  ID  					X   Y
	defb $00, WEAPON.Penetrator,	$12,$0C	; Penetrator
	defb $00, WEAPON.Backlash,		$16,$0C	; Backlash

	defb $03, WEAPON.Healer,		$19,$08	; Healer
	defb $03, WEAPON.Blaster,		$1C,$08	; Blaster

	defb $05, WEAPON.Healer,		$0C,$08	; Healer
	defb $05, WEAPON.Jackrabbit,	$0E,$08	; Jackrabbit

	defb $08, WEAPON.Blaster,		$06,$08	; Blaster

	defb $0A, WEAPON.Blaster,		$0E,$0C	; Blaster
	defb $0A, WEAPON.Lifter,		$12,$0C	; Lifter
	defb $0A, WEAPON.Jackrabbit,	$8C,$0C	; Jackrabbit

	defb $0B, WEAPON.Jackrabbit,	$4A,$0C	; Jackrabbit

	defb $FF				; terminator


	include "data/data_953B-95FA__levels.asm"
	include "data/font_chars__95FB-967C.asm"
	include "data/font_digits__967D-96AE.asm"
	include "data/font_symbols__96AF-96BD.asm"
	include "code/96BE-970C__find_char_gfx.asm"



L970D:
	defb $00
L970E:
	defb $00,$01
L9710:
	defb $FF
MENU_COLOR_BLINK:
	defb $00,$01,$02,$03,$04,$05,$06,$07
	defb $07,$06,$05,$04,$03,$02,$01,$00
    
COLOR_BLINKER:
    defb $00,$00

; Routine at 9723
L9723:
	ld a, $FF
	ld (L970D), a
	ld a, (L9710)
	and a
	call z, panel_to_buffer
	xor a
	ld (L9710), a
	call L984D
	call clear_scr_more
	ld hl, BUFF_F2F0
	ld de, BUFF_F2F0+1
	ld bc, $0050
	ld (hl), $00
	ldir
	ld hl, L99F0
	ld de, $000B
	ld bc, $0A06
	call L99B8
	ld hl, L9BD0
	ld de, $0613
	ld bc, $0201
	call L99B8
	ld hl, $52E0
	ld b, $20
	or $FF
L9723_0:
	ld (hl), a
	inc l
	djnz L9723_0

	ld hl, L9BE0
	ld de, $160A
	ld bc, $0C02
	call L99B8

	include "code/9775-9875__main_menu_loop.asm"
	include "code/9876-9898__col_row_to_attr.asm"
	include "code/9899-992E__draw_main_menu.asm"
	include "code/992F-9950__clear_scr_more.asm"
	include "code/9951-999D__draw_multi_logo.asm"
	include "code/999E-99B7__find_bmp_addr.asm"
	include "code/99B8-99EF___UNKNOWN.asm"

	include "data/data_99F0-9C9F.asm"

	include "code/9CA0-9CBE__panel_to_buffer.asm"
	include "code/9CBF-9CD8__print_string.asm"
	include "code/9CD9-9D00__print_char.asm"


MAINMENU_ICONS:
	;    row col sprite
	defb $07,$00,$41
	defb $09,$00,$44
	defb $0B,$00,$42
	defb $0D,$00,$45
	defb $0F,$00,$43
	defb $11,$00,$46
	defb $13,$00,$45
	
HISCORE:
	defb $00,$00,$00,$00

	include "code/9D1A-9E0F__show_main_menu.asm"
	include "code/9E10-9E3A___UNKNOWN.asm"
	include "code/9E3B-9E7A__redefine_keys.asm"
	include "code/9E7B-9E8F__enter_new_key.asm"


WORD_FIRE:
	ABYTEC 0 "FIRE"

WORD_UP:
	ABYTEC 0 "UP  "

WORD_DOWN:
	ABYTEC 0 "DOWN"

WORD_LEFT:
	ABYTEC 0 "LEFT"

WORD_RIGHT:
	ABYTEC 0 "RIGHT"

WORD_PRESS:
	ABYTEC 0 "Press"


L9EAA:
	defb $47,$46,$07,$06,$FF


copy_F2F0_buff:
	ld de, LF0C0
	ld hl, BUFF_F2F0
	ld b, $38
L9EAF_0:
	push hl
	ld c, 20		;$14
	DUP 10
		ldi
	EDUP
	 
	pop hl
	inc hl
	djnz L9EAF_0

	ret


	include "data/multicolor_9ED3-9F2D.asm"
	include "code/9F2E-9F61__prepare_multicolor.asm"
	include "code/9F62-9F6C__detect_kempston.asm"


TELEPORT_1:
	defb 0
TELEPORT_2:
	defb 0
TELEPORT_3:
	defb 0

L9F70:
	defb 0
	
PASS_BUFFER:
	defs $11


	include "code/9F82-9FF8__enter_password.asm"


WORD_DOTS:
	ABYTEC 0 "................"


PASS_1:
	; MAYHEM
	defb $72,$10,$54,$64,$22,$72,$00
PASS_2:
	; TRANSMOGRIFY
	defb $24,$23,$10,$73,$11,$72,$51,$14,$23,$52,$13,$54,$00
PASS_3:
	; VALKYR
	defb $04,$10,$61,$62,$54,$23,$00
PASS_4:
	; PETALSOFDOOM
	defb $50,$22,$24,$10,$61,$11,$70,$51,$13,$70,$12,$51,$51,$72,$00


	include "code/A033-A03F__match_buffer.asm"
	include "code/A040-A080___UNKNOWN.asm"


SINCLAIR_KEYS:
	defb $40,$41,$42,$44,$43

CURSOR_KEYS:
	defb $40,$43,$44,$34,$42

DEFINED_KEYS:
	defb $70,$50,$61,$20,$21


	include "code/A090-A0B1___UNKNOWN.asm"
	include "code/A0B2-A0F0__scan_keyboard.asm"


KEYBOARD:
	defb $40, "ZXCV"		; Caps Shift
	defb "ASDFG"
	defb "QWERT"
	defb "12345"
	defb "09876"
	defb "POIUY"
	defb $0D, "LKJH"		; Enter
	defb " ", $40, "MNB"		; Symbol Shift


	include "code/A119-A137__decode_char.asm"


KEY_FIRE_CURRENT:
	defb $00
KEY_FIRE_PREVIOUS:
	defb $00
KEMPSTON_YES:
	defb $01


	include "code/A13B-A14F__is_fire_pressed.asm"


;CONTROL_KEYS:
KEY_FIRE:
	defb $40
KEY_UP:
	defb "A"
KEY_DOWN:
	defb "B"
KEY_LEFT:
	defb "D"
KEY_RIGHT:
	defb "C"


	include "code/A155-A193__test_keys.asm"
	include "code/A194-A1EF___UNKNOWN.asm"
	include "code/A1F0-A252__playfield_to_screen.asm"


LA253:
	defs $70
	defs $08

LA2CB:
	defb $00,$00
    
LA2CD:
	defb 0
LA2CE:
	defb 0
LA2CF:
	defb 0


	include "code/A2D0-A348___UNKNOWN.asm"
	include "code/A349-A3ED___UNKNOWN.asm"


LA3EE:
	defb $00,$00

LA3F0: 
	defb $00,$00


	include "code/A3F2-A43E__multipliers.asm"


; player structure???

LA43F:
	defb $01
	
	defb $00

PLAYER_FACING: 
	defb $C8
PLAYER_X_COORD:
	defb $64
PLAYER_Y_COORD:
	defb $60


PLAYER_WIDTH:
	defb $04
	
	defb $04,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
LA44F:
	defb $00 			; number of frames?
	
LA450:	; ????
	defb $00,$00
LA452:
	defb $00,$00,$00

PLAYER_SPRITEADR:
	defb $00,$00

	defb $00,$01,$00
LA45A:
	defb $00  			; x displacement

	defb $00,$00,$00

L_A45E:
	defb $00,$47,$00,$00,$00,$00,$00
LA465:
	defb $01,$00
	defb $00
LA468:
	defb $00
LA469:
	defb $00,$02,$02,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$04
	defb $FF,$00,$00,$00,$00,$00,$46,$00
LA487:
	defb $00,$00,$00,$00


	include "data/aliens_A48B-A56E.asm"

	include "code/A56F-A776___UNKNOWN.asm"
	include "code/A777-A7F2___UNKNOWN.asm"
	include "code/A7F3-A85F___UNKNOWN.asm"
	include "code/A860-A899__generate_tables.asm"

	; draw level
	include "code/A899-A9BD__UNKNOWN.asm"
	include "code/A9BE-AA71__draw_boxes.asm"


LAA72:
	defb $00,$00
BRIDGE_DIR:
	defb $00


	include "code/AA75-AAA0___UNKNOWN.asm"
	include "code/AAA1-ABB4___UNKNOWN.asm"


LABB5:
	defb $60,$61,$62,$63,$9C,$9D,$BC,$BD
	defb $E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9
	defb $EB,$EC,$ED,$EE,$00

LABCA:
	defb $51,$52,$71,$72,$A1,$A2,$C0,$C1
	defb $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7
	defb $E8,$E9,$00
	
LABDD:
	defb $6C,$E2,$E3,$E4,$E5,$E6,$E7,$E8
	defb $E9,$00
	
LABE7:
	defb $E0,$E1,$E2,$E3,$E5,$E6,$E7,$E8
	defb $E9,$EA,$EB,$EC,$00
	
LABF4:
	defw LABB5
	defw LABCA
	defw LABDD
	defw LABE7

LABFC:
	defb $00


	include "code/ABFD-AC41___UNKNOWN.asm"
	include "code/AC42-AC7E__do_cannon.asm"


LAC7F:
	defb $00


LAC80:
	xor a
	ex af, af'
	ld hl, LF0C0
	ld de, $0020
	ld b, $EF
LAC80_0:
	ld c, (hl)
	ld a, (bc)
	bit 7, a
	jr nz, LAC80_1
	add hl, de
	ex af, af'
	add a, $08
	ex af, af'
	jr LAC80_0
LAC80_1:
	ex af, af'
	ld (LAC7F), a
	ret


	include "code/AC9C-ACBB___UNKNOWN.asm"
	include "code/ACBC-ACD9__check_teleports.asm"
	include "code/ACDA-AD27___UNKNOWN.asm"
	include "code/AD28-ADBE__welcome_message.asm"
	include "code/ADBF-ADD1__decode_pass.asm"
	include "code/ADD2-ADF5__decrease_penetrator.asm"
	include "code/ADF6-AE1C__game_finished.asm"


FOUND_SCOTT:
	ABYTEC 0 "YOU HAVE FOUND SCOTT......"

WELL_DONE:
	ABYTEC 0 "WELL DONE."

SCORE_BUFFER:
	defb $00,$00,$00,$00	; digits encoded as nibbles


	include "code/AE45-AE60__increase_score.asm"
	include "code/AE60-AEA5__print_score.asm"


ENERGY:
	defb $00
ENERGY_TMP:
	defb $00


	include "code/AEA8-AF0B__draw_energy.asm"


SLOT.BLINK:
	defb $00,$00
	
CURRENT_WEAPON:
	defb $00
	
WEAPON_TEXT_LEN:
	defb $00

WEAPON_TEXT:
	defb $00,$00
LETTER_SCROLLER:
	defb $00,$00
LAF14:
	defb $00

BUFFER_AF15:
	defb $00,$00,$00,$00,$00,$00
	
BOX.1:
	defb $00,$00,$00,$00,$00,$00,$00,$00

BOX.2:
	defb $00,$00,$00,$00,$00,$00,$00,$00

SLOT.1:		; AF2B
	defb $61,$00,$00,$00
SLOT.2:		; AF2F
	defb $64,$00,$00,$00
SLOT.3:		; AF33
	defb $67,$00,$00,$00
SLOT.4:		; AF37
	defb $6A,$00,$00,$00

X_BUFFER:
	defb $00	; 0  empty
	defb $00	; 1  penetrator
	defb $00	; 2  ultra flash
	defb $00	; 3  mirage
	defb $00	; 4  healer
	defb $01	; 5  jackrabbit
	defb $01	; 6  lifter
	defb $03	; 7  blaster
	defb $02	; 8  backlash
	defb $06	; 9  lava shot
	defb $01	; 10 streamer

BOX.COLORS:
	defb COLOR.BLACK	; 0  empty
	defb COLOR.GREEN	; 1  penetrator
	defb COLOR.RED      ; 2  ultra flash
	defb COLOR.MAGENTA  ; 3  mirage
	defb COLOR.GREEN    ; 4  healer
	defb COLOR.SKYBLUE  ; 5  jackrabbit
	defb COLOR.YELLOW   ; 6  lifter
	defb COLOR.WHITE    ; 7  blaster
	defb COLOR.WHITE    ; 8  backlash
	defb COLOR.RED      ; 9  lava shot
	defb COLOR.MAGENTA  ; 10 streamer
	
ACTIVE_SLOT: 
	defb $00,$00


	include "code/AF53-AF81__show_weapon_slot.asm"
	include "code/AF82-AFF9__message_scroller.asm"
	include "code/AFFA-B023__slot_blinking.asm"
	include "code/B024-B088__show_slot_box.asm"
	include "code/B089-B0FA___UNKNOWN.asm"


MESSAGE_ADDRESS:
	defb $00,$00
MESSAGE_LENGTH: 
	defb $00
LB0FE:
	defb $00


	include "code/B0FF-B11A__set_new_message.asm"
	include "code/B11B-B20F__collect_box.asm"
	include "code/B210-B237___UNKNOWN.asm"
	include "code/B238-B275___UNKNOWN.asm"
	include "code/B276-B2C4___UNKNOWN.asm"
	include "code/B2C5-B2F0___UNKNOWN.asm"


; Routine at B2F1
LB2F1:
	call LB2F9
	call LB33D
	ret


	include "code/B2F8-B33C___UNKNOWN.asm"
	include "code/B33D-B3E5___UNKNOWN.asm"


LB3E6:
	defb $00,$00
LB3E8:
	defb $00,$00
	
LB3EA: 
	defb $00

; Routine at B3EB
LB3EB:
	ld hl, LF0C0-1		;LF0BF
	ld bc, $1800
LB3EB_0:
	DUP 8
		ld (hl), c
		dec l
	EDUP
	djnz LB3EB_0

; This entry point is used by the routines at LB87F and LB9B1.
LB3EB_1:
	ld a, (PLAYER_Y_COORD)
	add a, $30
	cp $A0
	jr c, LB3EB_2

	ld a, $FF
	ld (LB2F8), a
LB3EB_2:
	ld ix, LA43F
	ld a, (LBAA7)
	and a
	jp nz, LB3EB_6

	ld a, (LA43F)

	cp $05
	jr z, LB3EB_4

	cp $06
	jr z, LB3EB_4

	ld (ix+$12), $00
	ld a, (KEY_FIRE_CURRENT)
	bit 1, a
	jr z, LB3EB_3

	ld (ix+$02), $80
	ld (ix+$12), $FE
LB3EB_3:
	bit 0, a
	jr z, LB3EB_4

	ld (ix+$02), $00
	ld (ix+$12), $02
LB3EB_4:
	call LB5FD

	ld (ix+$13), $00
	ld a, (PLAYER_X_COORD)

	cp $41
	jr nc, LB3EB_5

	ld (ix+$13), $80
LB3EB_5:
	cp $B2
	jr c, LB3EB_6

	ld (ix+$13), $9D
LB3EB_6:
	ld a, (LA43F)

	cp $01
	jp nz, action_by_accum

	ld iy, LB4C0
; This entry point is used by the routine at LB99B.
LB3EB_7:
	ld a, (KEY_FIRE_CURRENT)
	bit 2, a
	jr z, LB3EB_8

pressed_down:
	ld hl, (LB3E8)
	ld a, (hl)

	cp $14
	jp z, LB6B3

	cp $15
	jp z, LB6B3

	inc hl
	ld a, (hl)

	cp $14
	jp z, LB6B3

	cp $15
	jp z, LB6B3

	ld a, (LEVEL_NUMBER)
	and a
	jr nz, LB3EB_8

	ld a, (ROOM_NUMBER)

	cp $28
	jr nz, LB3EB_8

	ld hl, (LB3E8)
	ld de, $0081
	add hl, de
	ld a, (hl)

	cp $1C
	jr nz, LB3EB_8

	ld a, (PLAYER_X_COORD)
	sub $40
	rlca
	rlca
	rlca
	and $03
	ld e, a
	ld d, $00
	ld hl, TELEPORT_1
	add hl, de
	ld a, (hl)
	and a
	jr z, LB3EB_8
	jp LB9C5

LB3EB_8:
	jp (iy)

; Routine at B4C0
LB4C0:
	call LB706
	and a
	jp z, LB6E8
	bit 7, (ix+$02)
	jr nz, LB4C0_0
	ld hl, (LB3E8)
	ld de, $0082
	add hl, de
	call LB993
	jr c, LB4C0_2
	jr LB4C0_1
LB4C0_0:
	ld hl, (LB3E8)
	ld de, $0081
	add hl, de
	call LB993
	jr c, LB4C0_2
LB4C0_1:
	ld de, $0020
	add hl, de
	call LB993
	jr nc, LB4C0_2
	ld a, (ix+$12)
	ld (ix+$1B), a
	ld (ix+$10), $02
	ld a, $03
	ld (ix+$00), a
	jp action_by_accum

LB4C0_2:
	ld a, (KEY_FIRE_CURRENT)
	and $0F
	jr nz, LB4C0_3
	ld a, $08
	ld (LA43F), a
	jp action_by_accum

LB4C0_3:
	ld c, a
	bit 2, c
	jr z, LB4C0_4
	ld a, (PLAYER_Y_COORD)
	add a, $08
	ld (PLAYER_Y_COORD), a
	ld a, $04
	ld (LA43F), a
	jp action_by_accum

LB4C0_4:
	bit 3, c
	jr z, LB4C0_7
	ld iy, (ACTIVE_SLOT)
	ld a, (iy+$01)
	cp $05
	jp z, LB8DE
	bit 7, (ix+$13)
	jr nz, LB4C0_6
	ld a, (LB3EA)
	and a
	jr nz, LB4C0_5
	ld hl, (LB3E6)
	call LB993
	ret c
LB4C0_5:
	ld hl, (LB3E8)
	ld de, $FFE0		; -32
	add hl, de
	call LB993
	ret c
	inc l
	call LB993
	ret c
LB4C0_6:
	ld (ix+$11), $F7
	ld a, (ix+$12)
	ld (ix+$1B), a
	ld a, $05
	ld (LA43F), a
	jp action_by_accum

LB4C0_7:
	bit 1, c
	jr z, LB4C0_11
	bit 7, (ix+$13)
	jr nz, LB4C0_10
	ld a, (LB3EA)
	and a
	jr z, LB4C0_8
	ld hl, (LB3E6)
	ld de, $0040
	add hl, de
	call LB993
	jr c, LB4C0_10
	ld de, $0020
	jr LB4C0_9
LB4C0_8:
	ld hl, (LB3E6)
	call LB993
	ret c
	ld de, $0020
	add hl, de
	call LB993
	ret c
	add hl, de
	call LB993
	ret c
LB4C0_9:
	add hl, de
	call LB993
	jp c, LB647

LB4C0_10:
	ld a, (PLAYER_X_COORD)
	cp $3B
	jp c, go_left_room

	sub $02
	ld (PLAYER_X_COORD), a

	ret

LB4C0_11:
	bit 0, c
	ret z
	bit 7, (ix+$13)
	jr nz, LB4C0_14
	ld a, (LB3EA)
	and a
	jr z, LB4C0_12
	ld hl, (LB3E6)
	ld de, $0040
	add hl, de
	call LB993
	jr c, LB4C0_14
	ld de, $0020
	jr LB4C0_13
LB4C0_12:
	ld hl, (LB3E6)
	call LB993
	ld de, $0020
	add hl, de
	call LB993
	ret c
	add hl, de
	call LB993
	ret c
	add hl, de
LB4C0_13:
	call LB993
	jp c, LB647
LB4C0_14:
	ld a, (PLAYER_X_COORD)
	cp $B6
	jp nc, go_right_room

	add a, $02
	ld (PLAYER_X_COORD), a

	ret


	include "code/B5FD-B628___UNKNOWN.asm"


; Routine at B629
LB629:
	ld a, (LA452)
	and $1F
	ld e, a
	ld d, $00
	ld a, (PLAYER_Y_COORD)
	and $F8
	ld l, a
	ld h, d
	add hl, hl
	add hl, hl
	add hl, de
	ld de, LF0C0
	add hl, de
	ld (LB3E8), hl
	ld de, $0080
	add hl, de
	ret

; Routine at B647
LB647:
	ld a, (ix+$12)
	ld (ix+$1B), a
	ld (ix+$10), $02
	ld a, $02
	ld (ix+$00), a
	jp action_by_accum


	include "code/B659-B6D7__change_room.asm"


; Data block at B6D8
LB6D8:
	defb $DD,$2A,$0B,$95,$DD,$7E,$03,$FE
	defb $FF,$C8,$32,$0A,$95,$C3,$9D,$A8

; Routine at B6E8
LB6E8:
	ld iy, (ACTIVE_SLOT)
	ld a, (iy+$01)
	cp $05
	jp z, LB8DE
	ld a, (ix+$12)
	ld (ix+$1B), a
; This entry point is used by the routine at LB7B5.
LB6E8_0:
	ld (ix+$11), $01
	ld a, $06
	ld (LA43F), a
	jp action_by_accum ;LB72D

; Routine at B706
LB706:
	push de
	push bc
	bit 7, (ix+$13)
	jr z, LB706_0
	call LB629
	jr LB706_1
LB706_0:
	ld hl, (LB3E8)
	ld de, $0081
	add hl, de
LB706_1:
	ld c, $00
	call LB993
	jr nc, LB706_2
	inc c
LB706_2:
	inc l
	call LB993
	jr nc, LB706_3
	inc c
LB706_3:
	ld a, c
	pop bc
	pop de
	ret


	include "code/B72D-B75A__action_by_accum.asm"
	include "code/B75B-B79D__go_stairs.asm"
	include "code/B79E-B7B4__go_sit_down.asm"
	include "code/B7B5-B840__go_jump.asm"
	include "code/B841-B8DD__go_fall.asm"


LB8DE:
	ld (ix+$00), $07
	ld (ix+$11), $04
	ret


	include "code/B8E7-B99A__go_fly.asm"
	include "code/B99B-B9B7___UNKNOWN.asm"


LB9B8:
	dec (ix+$10)
	ret nz
	call playfield_to_screen
	call playfield_to_screen
	jp LBAA8_1


LB9C5:
	ld (ix+$00), $0A
	ld (ix+$10), $32
	ld a, $01
	ld (LA2CF), a
	ld a, $09
	call L93DC
	ret


	include "code/B9D8-BA20___UNKNOWN.asm"
	include "code/BA21-BA67___UNKNOWN.asm"


go_appear:
	ld a, $09
	call L93DC
	ld a, $32  ; duration
	ld (ix+$10), a
	ld a, $04
	ld (LA2CF), a
	inc (ix+$00)
	ret


LBA7B:
	ld a, (ix+$10)
	and $0F
	jr nz, LBA7B_0
	ld hl, LA2CF
	dec (hl)
LBA7B_0:
	dec (ix+$10)
	ret nz
	ld (ix+$00), $08
	xor a
	ld (LA2CF), a
	ret


	include "code/BA93-BAA6___UNKNOWN.asm"


LBAA7:
	defs $01

; Routine at BAA8
LBAA8:
	ld a, $08
	call L93DC
	ld a, $FF
	ld (LBAA7), a
	xor a
	ld (LA2CF), a
	ld b, $20
LBAA8_0:
	push bc
	ld hl, PLAYER_Y_COORD
	inc (hl)
	call LCACD
	call LA2D0
	pop bc
	djnz LBAA8_0

	call playfield_to_screen
	call playfield_to_screen

; This entry point is used by the routines at LB9B8 and LBDA4.
LBAA8_1:
	ld a, (LFFFE)
	ld (L946C), a
	ld a, $02
	ld (L9222), a

	ld de, $0407
	ld hl, MISS_TERM

	call term_print

	ld hl, HISCORE
	ld de, SCORE_BUFFER
	ld b, $04
loop_hiscore:
	ld a, (de)
	cp (hl)
	jp c, diagonal_clear
	jr nz, LBAA8_3

	inc hl
	inc de
	djnz loop_hiscore

LBAA8_3:
	ld hl, SCORE_BUFFER
	ld de, HISCORE
	ld bc, $0004
	ldir
	jp diagonal_clear


MISS_TERM:
	ABYTEC 0 "MISSION TERMINATED"


	include "code/BB13-BB4B__term_print.asm"
	include "code/BB4C-BB77___UNKNOWN.asm"
	include "code/BB78-BC95___UNKNOWN.asm"


; Routine at BC96
LBC96:
	ld a, (LA465)
	and a
	jr z, LBC96_0
	ld a, (ix+$00)
	and $BF
	jr z, LBC96_0
	cp $03
	jr z, LBC96_0
	ld a, (LA468)
	add a, $06
	sub (ix+$03)
	ld l, a
	ld a, (ix+$05)
	add a, a
	add a, a
	add a, $04
	cp l
	jr c, LBC96_0
	ld a, (LA469)
	add a, $0C
	sub (ix+$04)
	ld l, a
	ld a, (ix+$06)
	add a, a
	add a, a
	add a, a
	add a, $08
	cp l
	jr c, LBC96_0
	ld a, (ix+$00)
	cp $0A
	jr z, LBC96_0
	ld a, (LA487)
	ld (ix+$22), a
	and a
	ret
LBC96_0:
	or $FF
	ret

; Routine at BCE0
LBCE0:
	ld a, (LBAA7)
	and a
	ret nz
	ld a, (LA43F)
	cp $0A
	jp z, LBDA4_1
	ld ix, (ACTIVE_SLOT)
	ld a, (ix+$01)
	and a
	ret z
	cp $05
	jp c, LBDA4

	ld a, (KEY_FIRE_CURRENT)
	bit 4, a
	ret z

	ld a, (KEY_FIRE_PREVIOUS)
	bit 4, a
	ret nz

	ld a, (LA465)
	and a
	ret nz
	ld c, $01
	ld a, (ix+$01)
	cp $06
	jr nz, LBCE0_0
	ld c, $08
LBCE0_0:
	ld a, c
	call LB210
	jr nc, LBCE0_1
	ret
LBCE0_1:
	ld a, (ix+$01)
	sub $05
	call L93DC
	ld iy, LA465
	ld a, (PLAYER_Y_COORD)
	add a, $05
	ld (LA469), a
	ld a, (PLAYER_FACING)
	add a, a
	ld a, (PLAYER_X_COORD)
	jr c, LBCE0_2
	ld e, $06
	ld (iy+$02), $00
	add a, $04
	jr LBCE0_3
LBCE0_2:
	ld e, $FA
	ld (iy+$02), $FF
LBCE0_3:
	add a, $02
	ld (LA468), a
	ld (iy+$1B), e
	ld (iy+$00), $01
	ld a, (ix+$01)
	sub $05
	ld (iy+$18), a
	ld (iy+$16), $E0
	ld (iy+$17), $D6
	ld a, (ix+$03)
	ld (iy+$21), a
	ld a, (ix+$01)
	cp $06
	jr z, LBCE0_4
	xor a
	ld (iy+$22), a
	ret
LBCE0_4:
	or $FF
	ld (iy+$22), a
	ret

; Routine at BD7F
LBD7F:
	xor a
	ld (LA465), a
	ret

; Routine at BD84
LBD84:
	ld ix, LA465
	ld a, (ix+$03)
	add a, (ix+$1B)
	ld (ix+$03), a
	cp $38
	jr c, LBD84_0
	cp $C4
	jr nc, LBD84_0
	call LC401
	jr c, LBD84_0
	ret
LBD84_0:
	ld (ix+$00), $00
	ret


	include "code/BDA4-BE0C___UNKNOWN.asm"


LBE0D:
	defs $01


LBE0E:
	ld a, (LB3EA)
	and a
	jr nz, LBE0E_0

	ld a, $FF
	ld (LB3EA), a
	ld a, $07
	call L93DC
LBE0E_0:
	ld a, $02
	ld (LA2CF), a
	ld hl, LBE0D
	ld a, (LCC5C)
	and $01
	add a, (hl)
	ld (hl), $00
	call LB210
	ld a, (ix+$01)
	and a
	ret nz
	jp LBDA4_1


LBE39:
	ret
    

LBE3A:
	ret


	include "data/alien_templates_BE3B-BF2A.asm"

	include "code/BF2B-BFD1__choose_alien_routine.asm"
	include "code/BFD2-C04A__do_rockets.asm"
	include "code/C04B-C07D__do_spheres.asm"
	include "code/C07E-C0A5__do_jumpers.asm"
	include "code/C0A6-C0D5__do_mushrooms.asm"


LC0D6:
	defb $00
LC0D7: 
	defb $00,$00
	

	include "code/C0D9-C0F7__do_harrier.asm"
	include "code/C0F7-C115__do_bomber.asm"
	include "code/C116-C166__do_volcano.asm"
	include "code/C167-C18B__do_bomb.asm"


kill_all_aliens:
	ld iy, ALIEN.1
	ld de, $0026
	ld b, $06
loop_kill_aliens:
	ld (iy+$1F), $FF
	add iy, de
	djnz loop_kill_aliens

	ret

	include "code/C19E-C1F0__do_mortar.asm"

	db $00
	db $00

	include "code/C1F3-C26D__do_snake.asm"

LC26E:
	db $A7



LC26F:
	ld (ix+$10), $04
	ld (ix+$00), $03
	call copy_alien_template
	call generate_random
	and $03
	add a, $0B
	jp L93DC


	include "code/C284-C2C0__hit_alien.asm"


LC2C1:
	ld d, (ix+$15)
	ld e, (ix+$14)

	jp increase_score


	include "code/C2CA-C2D8__decrease_energy.asm"


LC2D9:
	ld a, (LB3EA)
	and a
	jr nz, LC2D9_3
	ld a, (ix+$06)
	add a, a
	add a, a
	add a, a
	ld d, a
	ld a, (ix+$05)
	add a, a
	add a, a
	ld e, a
	ld a, (PLAYER_X_COORD)
	sub (ix+$03)
	jr nc, LC2D9_0
	cp $F6
	jr c, LC2D9_3
	jr LC2D9_1
LC2D9_0:
	add a, $04
	cp e
	jr nc, LC2D9_3
LC2D9_1:
	ld a, (PLAYER_Y_COORD)
	sub (ix+$04)
	jr nc, LC2D9_2
	cp $E4
	jr c, LC2D9_3
	xor a
	ret
LC2D9_2:
	cp d
	jr nc, LC2D9_3
	xor a
	ret
LC2D9_3:
	or $FF
	ret


	include "code/C315-C361__alien_vectors.asm"


LC362:
	ld a, (ix+$04)
	add a, (ix+$1C)
	ld (ix+$04), a
; This entry point is used by the routine at LC5D9.
LC362_0:
	ld a, (ix+$03)
	add a, (ix+$1B)
	ld (ix+$03), a
	ret


	include "code/C375-C3A5___UNKNOWN_proc_1.asm"
	include "code/C3A6-C3F0___UNKNOWN_proc_2.asm"
	include "code/C3F1-C400___UNKNOWN_proc_3.asm"


; Routine at C401
LC401:
	ld a, (ix+$1D)
	and a
	ret nz
	ld a, (ix+$04)
	and $80
	ret nz
	ld h, a
	ld a, (ix+$04)
	and $F8
	ld l, a
	add hl, hl
	add hl, hl
	ld a, (ix+$03)
	sub $40
	and a
	ret M
	srl a
	srl a
	ld e, a
	ld d, $00
	add hl, de
	ld de, LF0C0
	add hl, de
	call LB993
	ret c
	ld e, l
	ld a, l
	and $1F
	add a, (ix+$05)
	cp $20
	ret nc
	ld a, l
	add a, (ix+$05)
	dec a
	ld l, a
	call LB993
	ret c
	ld l, e
	ld de, $0020
	ld b, (ix+$06)
LC401_0:
	add hl, de
	djnz LC401_0
	call LB993
	ret c
	ld a, l
	add a, (ix+$05)
	dec a
	ld l, a
	jp LB993


	include "code/C457-C520___UNKNOWN.asm"
	include "code/C521-C561___UNKNOWN_proc_5.asm"
	include "code/C562-C5D8___UNKNOWN_proc_6.asm"
	include "code/C5D9-C64D___UNKNOWN_proc_7.asm"
	include "code/C64E-C6B6___UNKNOWN_proc_8.asm"
	include "code/C6B7-C6B7__just_a_ret.asm"


LC6B8:
	call LC2C1
	ld a, (ix+$00)
	ld (ix+$00), $0A
	ld (ix+$1B), $00
	cp $05
	jr z, LC6CF
	ld (ix+$11), $00
	ret


LC6CF:
	ld (ix+$11), $40
	ret


	include "code/C6D4-C6F1___UNKNOWN_proc_10.asm"
	include "code/C6F2-C73E___UNKNOWN_proc_11.asm"
	include "code/C73F-C788___UNKNOWN_proc_12.asm"

	db $C9

	include "code/C78A-C7F3___UNKNOWN_proc_13.asm"
	include "code/C7F4-C81A__move_bomb.asm"
	include "code/C81B-C85F___UNKNOWN.asm"
	include "code/C860-C89A___UNKNOWN_proc_15.asm"
	include "code/C89B-C921___UNKNOWN_proc_16.asm"
	include "code/C922-C97F___UNKNOWN_proc_17.asm"
	include "code/C980-C9B7___UNKNOWN_proc_18.asm"
	include "code/C9B8-C9E9___UNKNOWN_proc_19.asm"


; Routine at C9EA
LC9EA:
	ld hl, SPRITE_E710
	ld a, (LA194)
	cp $03
	jr nz, LC9EA_0
	ld hl, SPRITE_E728
LC9EA_0:
	ld de, LCA35
	ld b, $00
	ld a, $08
LC9EA_1:
	ld (LCA29+1), a		; set SMC
	push hl
	ld a, (de)
	bit 7, a
	jr nz, LC9EA_3
	and $07
	dec a
	ld c, a
	add hl, bc
	ld (hl), $FF
	and a
	jr z, LC9EA_2
	ld (de), a
	jr LC9EA_5
LC9EA_2:
	ld a, $80
	ld (de), a
	jr LC9EA_5
LC9EA_3:
	and $07
	ld c, a
	add hl, bc
	ld (hl), $00
	inc a
	cp $07
	jr z, LC9EA_4
	or $80
	ld (de), a
	jr LC9EA_5
LC9EA_4:
	ld (de), a
LC9EA_5:
	pop hl
	ld c, $08
	add hl, bc
	inc de
LCA29:
	ld a, $00		; !!! SMC
	dec a
	jr nz, LC9EA_1
	ret


LCA35:
	defb $80,$81,$82,$83,$84,$85,$86,$07


	include "code/CA3D-CAAC__move_bridge.asm"


; Routine at CAAD
LCAAD:
	ld hl, LAAA1
	ld a, $01
LCAAD_0:
	ld e, (hl)
	inc hl
	ld d, (hl)
	inc hl
	bit 7, d
	ret z

	ld (de), a

	jp LCAAD_0


LCABD:
	defb $00
LCABE:
	defb $00
LCABF:
	defb $00
LCAC0:
	defb $00,$01,$02,$03,$02,$01,$00
LCAC7:
	defb $00,$01,$02,$03,$02,$01


LCACD:
	call LCAAD
	call move_bridge
	ld hl, LCABD
	ld a, (hl)
	inc a
	and $07
	ld (hl), a
	inc hl
	ld a, (hl)
	dec a
	jp p, LCACD_0
	ld a, $05
LCACD_0:
	ld (hl), a
	inc hl
	ld a, (hl)
	inc a
	cp $0C
	jr nz, LCACD_1
	xor a
LCACD_1:
	ld (hl), a
	ld a, (LA194)
	and a
	jr nz, LCB42
	ld a, (LCABD)
	rrca
	rrca
	rrca
	ld e, a
	ld d, $00
	ld hl, SPRITE_E600
	add hl, de
	ld de, SPRITE_E300
	ld bc, $0020
	ldir
	ld a, (LCABE)
	rrca
	rrca
	rrca
	ld e, a
	ld d, $00
	ld hl, SPRITE_E210
	add hl, de
	ld de, LE758
	ld bc, $0020
	ldir
	ld a, (LCABD)
	add a, a
	add a, a
	add a, a
	add a, a
	ld e, a
	ld d, $00
	ld hl, LE460
	add hl, de
	ld de, SPRITE_E4E0
	push hl
	push de
	ld bc, $0010
	ldir
	pop de
	pop hl
	inc h
	inc d
	ld bc, $0010
	ldir
	jp LC9EA

; Unused
LCB41:
	defs $01

; Routine at CB42
LCB42:
	cp $01
	jp nz, LCB42_1
	ld a, (LCABD)
	rrca
	rrca
	rrca
	ld l, a
	ld h, $00
	ld de, SPRITE_E400
	add hl, de
	ld de, SPRITE_E288
	ld a, e
	ld bc, $0010
	ldir
	ld e, a
	inc d
	ld bc, $0010
	ldir
	ld a, (LCABE)
	rrca
	rrca
	rrca

	ld l, a
	ld h, $00
	ld de, SPRITE_E630
	add hl, de
	ld de, SPRITE_E600
	ld bc, $0010
	ld a, e
	ldir
	ld e, a
	inc d
	ld bc, $0010
	ldir
	ld a, (LCB41)
	and a
	jr nz, LCB42_0
	ld a, (LCABE)
	cp $05
	jp nz, LC9EA
	call generate_random
	and $07
	jp nz, LC9EA

LCB42_0:
	ld a, (LCABE)
	ld (LCB41), a
	ld l, a
	ld h, $00
	ld de, LCAC0
	add hl, de
	ld a, (hl)
	add a, a
	add a, a
	add a, a
	add a, a
	ld l, a
	ld h, $00
	ld de, SPRITE_E788
	add hl, de
	ld de, SPRITE_E508
	ld bc, $0010
	ldir
	jp LC9EA
LCB42_1:
	cp $02
	jr nz, LCB42_2

	ld a, (LCABE)
	ld l, a
	ld h, $00
	ld de, LCAC7
	add hl, de
	ld a, (hl)
	add a, a
	add a, a
	add a, a
	ld l, a
	ld h, $00
	ld de, SPRITE_E3A0
	add hl, de
	ld de, SPRITE_E360
	ld bc, $0008
	ldir
	jp LC9EA

LCB42_2:
	ld a, (LCABF)
	;mult
	ld l, a
	ld h, $00
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, hl	; x8
	add hl, hl	; x16
	add hl, hl	; x32
	ld de, spriteset_1
	add hl, de
	;mult HL=spriteset_1 + A*32
	ld de, LE700
	ld bc, $0020
	ldir
	jp LC9EA



diagonal_clear:
	ld sp,STACK
	ei
	call L9723		; main menu loop
	call new_game	; draw room

LCBF9_0:
	call is_fire_pressed	 	; ? inkey
	call LB3EB		; show player
	call LBD84	 	; process fire
	call LB2F1		; ? drowning
	call hit_alien
	call LBCE0		; ? use weapon
	call LB089		; ? switch weapon
	call print_score

	ld a, (LB2F8)

	IFNDEF WATERPROOF
		and a
	ELSE
		xor a
	ENDIF

	jp nz, LBAA8

	ld a, (ENERGY)
	and a
	jr nz, LCBF9_1

	ld a, (LA43F)

	cp $09
	jr z, LCBF9_1

	ld a, $09
	ld (LA43F), a
	ld a, $32
	ld (LA44F), a
	ld a, $01
	ld (LA2CF), a
	ld (LBAA7), a
LCBF9_1:
	call draw_energy
	call show_weapon_slot
	call LCACD
	call LA2D0			; draw energy and loot
	ld hl, SLOT.BLINK
	inc (hl)
	ld hl, LCC5C
	ld a, (hl)
	add a, $01
	daa
	ld (hl), a
	jp LCBF9_0


	include "data/data_CC5C-CD5F.asm"
	include "data/sprites_CD60-CDDF__player_01.asm"
	include "data/sprites_CDE0-CE5F__player_02.asm"
	include "data/sprites_CE60-CEDF__player_03.asm"
	include "data/sprites_CEE0-CF5F__player_04.asm"
	include "data/sprites_CF60-CFDF__player_05.asm"
	include "data/sprites_CFE0-D05F__player_06.asm"
	include "data/sprites_D060-D0DF__player_07.asm"
	include "data/sprites_D0E0-D15F__player_08.asm"
	include "data/sprites_D160-D1DF__player_09.asm"
	include "data/sprites_D1E0-D25F__player_10.asm"
	include "data/sprites_D260-D39F.asm"
	include "data/font_big__D3A0-D43F.asm"
	include "data/sprites_D440-D57F.asm"
	include "data/sprites_D580-D6DF__weapons.asm"
	include "data/sprites_D6E0-D79F__bullets.asm"
	include "data/sprites_D7A0-D97F.asm"
	include "data/data_D980-DBBF.asm"
	include "data/sprites_DBC0-E7FF.asm"
	include "data/data_E800-EDFF.asm"
	include "data/colors_player_EE00-EEFF.asm"
	include "data/colors_backgr_EF00-EFFF.asm" 

	include "data/data_F000-F5FF.asm"
	include "data/data_F600-F7FF.asm"
	include "data/data_F800-FCFF.asm"
	include "data/data_FD00-FDFF.asm"


INT_VECTORS:	; must be aligned
	defs $100, 0

	include "data/data_FF00-FFF3.asm"

to_interrupt:
	jp interrupt

	defb $5A,$A5,$80,$E2,$88,$E2,$3C
	
LFFFE:
	defb $FF


last_jump:
	defb $18	; jr to_interrupt

	savebin "recompile/mask_3_loaded.bin",STARTBLOCK,$FFFF-STARTBLOCK+1
	savesna "recompile/mask_3_loaded.sna",startup
