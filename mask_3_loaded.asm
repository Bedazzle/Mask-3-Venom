; ZX-M8XXX helpers
; @main
; @entry startup

	device zxspectrum48

; sp 24576
;STARTGAME	EQU startup	; 9100	; 37120

	include "mask_3_constants.asm"


	ORG $6000

STARTBLOCK:
	include "data/6000-60FF__sprites.asm"
	include "data/6100-61FF__sprites.asm"
	include "data/6200-62FF__sprites.asm"
	
	include "data/6300-75FF__spritesheet_banks.asm"
	include "data/7600-84FF__rooms.asm"
	include "data/8500-90FF__backgr_tiles.asm"

	include "code/9100-915A__startup.asm"
	include "code/915B-9207__new_game.asm"
	include "code/9208-920F__deadly_loop.asm"
	include "code/9210-9221__striped_border.asm"


; small interrupt/sound scratch: SND_TRIG_1/SND_TRIG_2 = 128K sound-trigger flags (interrupt
; calls into copy_alien_template when set); FRAME_COUNTER = frame counter (inc per interrupt);
; BORDER_VALUE = current border/beeper port value.
SND_TRIG_1:
	DB $00
SND_TRIG_2:
	DB $FF
FRAME_COUNTER:
	DB $00
	
BORDER_VALUE:
	DB $00

	include "code/9226-92C2__interrupt.asm"
	include "code/92C3-92DF__generate_random.asm"

	include "code/92E0-9420__play_sfx.asm"
	include "code/9421-946B__process_sfx_channels.asm"


; per-type "reset this alien vector + silence its sound" flags, polled by
; clear_alien_vectors (RESET_JUMPER_SND/D/E -> state vectors 6/12/18).
RESET_JUMPER_SND:
	DB $00
RESET_VOLCANO_SND:
	DB $00
RESET_SNAKE_SND:
	DB $00


	include "code/946F-949E__clear_alien_vectors.asm"


; --- silence_sfx_if_flagged ----------------------------------
; @done
; If the reset flag RESET_JUMPER_SND is set, clear it and silence the object
; sound (SOUND_STATE). Called each frame from the interrupt.
silence_sfx_if_flagged:
	ld hl, RESET_JUMPER_SND
	ld a, (hl)
	and a
	ret z
	xor a
	ld (SOUND_STATE), a
	ld (hl), a
	ret


; Active object-sound state driven by sound_tick:
;   [0]   = frames remaining ($FF = indefinite, 0 = silent)
;   [1,2] = pitch accumulator (advanced by the source step each frame)
;   [3,4] = pointer to the source descriptor (its +$07/$08 = step)
SOUND_STATE:
	DB $00,$00,$00,$00


; --- load_sfx ------------------------------------------------
; @done
; Load a sound descriptor into SOUND_STATE (duration, start pitch,
; source pointer). Called by play_sfx. In: ix = descriptor
load_sfx:
	ld (SOUND_STATE+3), ix
	ld a, (ix+SFX.DURATION)
	ld (SOUND_STATE), a
	ld l, (ix+SFX.PITCH_LO)
	ld h, (ix+SFX.PITCH_HI)
	ld (SOUND_STATE+1), hl
	ret


; --- stop_sfx ------------------------------------------------
; @done
; Silence the object sound (clear the frame counter).
stop_sfx:
	xor a
	ld (SOUND_STATE), a

	ret


	include "code/94C8-9509__sound_tick.asm"


LEVEL_NUMBER:
	DB $00
	
ROOM_EXITS_ADDR:
	DB $00,$00
	
ROOM_NUMBER:
	DB $00

BOXES:
	;    Lvl  ID  					X   Y
	DB $00, WEAPON.Penetrator,	$12,$0C	; Penetrator
	DB $00, WEAPON.Backlash,		$16,$0C	; Backlash

	DB $03, WEAPON.Healer,		$19,$08	; Healer
	DB $03, WEAPON.Blaster,		$1C,$08	; Blaster

	DB $05, WEAPON.Healer,		$0C,$08	; Healer
	DB $05, WEAPON.Jackrabbit,	$0E,$08	; Jackrabbit

	DB $08, WEAPON.Blaster,		$06,$08	; Blaster

	DB $0A, WEAPON.Blaster,		$0E,$0C	; Blaster
	DB $0A, WEAPON.Lifter,		$12,$0C	; Lifter
	DB $0A, WEAPON.Jackrabbit,	$8C,$0C	; Jackrabbit

	DB $0B, WEAPON.Jackrabbit,	$4A,$0C	; Jackrabbit

	DB $FF				; terminator


	include "data/953B-95FA__levels.asm"
	include "data/95FB-967C__font_chars.asm"
	include "data/967D-96AE__font_digits.asm"
	include "data/96AF-96BD__font_symbols.asm"
	include "code/96BE-970C__find_char_gfx.asm"



; menu/HUD state flags: HUD_ACTIVE = in-game HUD active; IN_MENU = in main menu;
; PANEL_DRAWN = panel-drawn-once flag.
HUD_ACTIVE:
	DB $00
IN_MENU:
	DB $00,$01
PANEL_DRAWN:
	DB $FF
; colour-cycle sequence (0-7 then 7-0) for the pulsing menu-item highlight.
MENU_COLOR_BLINK:
	DB $00,$01,$02,$03,$04,$05,$06,$07
	DB $07,$06,$05,$04,$03,$02,$01,$00
    
COLOR_BLINKER:
    DB $00,$00

; --- setup_main_menu: draw the main-menu screen (banner/logo/hiscore panel) (@done)
setup_main_menu:
	ld a, $FF
	ld (HUD_ACTIVE), a
	ld a, (PANEL_DRAWN)
	and a
	call z, panel_to_buffer
	xor a
	ld (PANEL_DRAWN), a
	call menu_wipe_in
	call clear_scr_more
	ld hl, BUFF_F2F0
	ld de, BUFF_F2F0+1
	ld bc, $0050
	ld (hl), $00
	ldir
	ld hl, MENU_BANNER
	ld de, $000B
	ld bc, $0A06
	call draw_block
	ld hl, MENU_MID
	ld de, $0613
	ld bc, $0201
	call draw_block
	ld hl, $52E0
	ld b, $20
	or $FF
.fill:
	ld (hl), a
	inc l
	djnz .fill

	ld hl, MENU_TITLE
	ld de, $160A
	ld bc, $0C02
	call draw_block

	include "code/9775-9875__main_menu_loop.asm"
	include "code/9876-9898__col_row_to_attr.asm"
	include "code/9899-992E__draw_main_menu.asm"
	include "code/992F-9950__clear_scr_more.asm"
	include "code/9951-999D__draw_multi_logo.asm"
	include "code/999E-99B7__find_bmp_addr.asm"
	include "code/99B8-99EF__draw_block.asm"

	include "data/99F0-9C9F__menu_banner.asm"

	include "code/9CA0-9CBE__panel_to_buffer.asm"
	include "code/9CBF-9CD8__print_string.asm"
	include "code/9CD9-9D00__print_char.asm"


MAINMENU_ICONS:
	;    row col sprite
	DB $07,$00,$41
	DB $09,$00,$44
	DB $0B,$00,$42
	DB $0D,$00,$45
	DB $0F,$00,$43
	DB $11,$00,$46
	DB $13,$00,$45
	
HISCORE:
	DB $00,$00,$00,$00

	include "code/9D1A-9E0F__show_main_menu.asm"
	include "code/9E10-9E3A__clear_screen_pixels.asm"
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


MENU_ATTR_SEQ:
	DB $47,$46,$07,$06,$FF


copy_F2F0_buff:
	ld de, PLAYFIELD_MAP
	ld hl, BUFF_F2F0
	ld b, $38
.loop:
	push hl
	ld c, 20		;$14
	DUP 10
		ldi
	EDUP
	 
	pop hl
	inc hl
	djnz .loop

	ret


	include "data/9ED3-9F2D__multicolor.asm"
	include "code/9F2E-9F61__prepare_multicolor.asm"
	include "code/9F62-9F6C__detect_kempston.asm"


TELEPORT_1:
	DB 0
TELEPORT_2:
	DB 0
TELEPORT_3:
	DB 0

TELEPORT_4:
	DB 0
	
PASS_BUFFER:
	DS $11


	include "code/9F82-9FF8__enter_password.asm"


WORD_DOTS:
	ABYTEC 0 "................"


PASS_1:
	; MAYHEM
	DB $72,$10,$54,$64,$22,$72,$00
PASS_2:
	; TRANSMOGRIFY
	DB $24,$23,$10,$73,$11,$72,$51,$14,$23,$52,$13,$54,$00
PASS_3:
	; VALKYR
	DB $04,$10,$61,$62,$54,$23,$00
PASS_4:
	; PETALSOFDOOM
	DB $50,$22,$24,$10,$61,$11,$70,$51,$13,$70,$12,$51,$51,$72,$00


	include "code/A033-A03F__match_buffer.asm"
	include "code/A040-A080__wipe_screen.asm"


; control-key sets: packed keyboard matrix codes (halfrow<<4 | column) for the 5
; controls in order right, left, down, up, fire - one row per scheme (Sinclair
; joystick / Cursor / user-defined). read_key tests one code.
SINCLAIR_KEYS:
	DB $40,$41,$42,$44,$43

CURSOR_KEYS:
	DB $40,$43,$44,$34,$42

DEFINED_KEYS:
	DB $70,$50,$61,$20,$21


	include "code/A090-A0B1__read_key.asm"
	include "code/A0B2-A0F0__scan_keyboard.asm"


KEYBOARD:
	DB $40, "ZXCV"		; Caps Shift
	DB "ASDFG"
	DB "QWERT"
	DB "12345"
	DB "09876"
	DB "POIUY"
	DB $0D, "LKJH"		; Enter
	DB " ", $40, "MNB"		; Symbol Shift


	include "code/A119-A137__decode_char.asm"


KEY_FIRE_CURRENT:
	DB $00
KEY_FIRE_PREVIOUS:
	DB $00
KEMPSTON_YES:
	DB $01


	include "code/A13B-A14F__is_fire_pressed.asm"


;CONTROL_KEYS:
KEY_FIRE:
	DB $40
KEY_UP:
	DB "A"
KEY_DOWN:
	DB "B"
KEY_LEFT:
	DB "D"
KEY_RIGHT:
	DB "C"


	include "code/A155-A193__test_keys.asm"
	include "code/A194-A1EF__swap_spritesheet.asm"
	include "code/A1F0-A252__playfield_to_screen.asm"


SAVED_BOX_TILES:
	DS $70
	DS $08

DRAW_DEST:
	DB $00,$00
    
DRAW_COLOR:
	DB 0
DRAW_COLOR_BASE:
	DB 0
DISSOLVE:
	DB 0


	include "code/A2D0-A348__draw_all_actors.asm"
	include "code/A349-A3ED__pick_actor_sprite.asm"


pad_A3EE:
	DB $00,$00

pad_A3F0: 
	DB $00,$00


	include "code/A3F2-A43E__calc_frame_addr.asm"


; PLAYER: the player's 38-byte actor record (same ALIEN layout as ALIEN.1..6)

PLAYER:
	DB $01
	
	DB $00

PLAYER_FACING: 
	DB $C8
PLAYER_X_COORD:
	DB $64
PLAYER_Y_COORD:
	DB $60


PLAYER_WIDTH:
	DB $04
	
	DB $04,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
PLAYER_FRAME_COUNT:
	DB $00 			; number of frames?
	
PLAYER_JUMP_IDX:	; ????
	DB $00,$00
PLAYER_MAP_X:
	DB $00,$00,$00

PLAYER_SPRITEADR:
	DB $00,$00

	DB $00,$01,$00
PLAYER_X_DISP:
	DB $00  			; x displacement

	DB $00,$00,$00

L_A45E:
	DB $00,$47,$00,$00,$00,$00,$00
PLAYER_BULLET:
	DB $01,$00
	DB $00
BULLET_X:
	DB $00
BULLET_Y:
	DB $00,$02,$02,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$04
	DB $FF,$00,$00,$00,$00,$00,$46,$00
BULLET_HIT:
	DB $00,$00,$00,$00


	include "data/A48B-A56E__aliens.asm"

	include "code/A56F-A776__draw_sprite.asm"
	include "code/A777-A7F2__expand_sprite.asm"
	include "code/A7F3-A85F__mirror_sprite.asm"
	include "code/A860-A899__generate_tables.asm"

	; draw level
	include "code/A899-A9BD__draw_room.asm"
	include "code/A9BE-AA71__draw_boxes.asm"


BRIDGE_PTR:
	DB $00,$00
BRIDGE_DIR:
	DB $00


	include "code/AA75-AAA0__find_bridge.asm"
	include "code/AAA1-ABB4__list_special_tiles.asm"


TILE_SET_1:
	DB $60,$61,$62,$63,$9C,$9D,$BC,$BD
	DB $E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9
	DB $EB,$EC,$ED,$EE,$00

TILE_SET_2:
	DB $51,$52,$71,$72,$A1,$A2,$C0,$C1
	DB $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7
	DB $E8,$E9,$00
	
TILE_SET_3:
	DB $6C,$E2,$E3,$E4,$E5,$E6,$E7,$E8
	DB $E9,$00
	
TILE_SET_4:
	DB $E0,$E1,$E2,$E3,$E5,$E6,$E7,$E8
	DB $E9,$EA,$EB,$EC,$00
	
SPECIAL_TILE_TABLES:
	DW TILE_SET_1
	DW TILE_SET_2
	DW TILE_SET_3
	DW TILE_SET_4

SEARCH_TILE:
	DB $00


	include "code/ABFD-AC41__find_room_tile.asm"
	include "code/AC42-AC7E__do_cannon.asm"


GROUND_ROW:
	DB $00


; --- find_ground_row: scan the room map for the ground tile (bit-7 bg colour); store its Y in GROUND_ROW (move_jumper arc base) (@done)
find_ground_row:
	xor a
	ex af, af'
	ld hl, PLAYFIELD_MAP
	ld de, $0020
	ld b, $EF
.scan:
	ld c, (hl)
	ld a, (bc)
	bit 7, a
	jr nz, .found
	add hl, de
	ex af, af'
	add a, $08
	ex af, af'
	jr .scan
.found:
	ex af, af'
	ld (GROUND_ROW), a
	ret


	include "code/AC9C-ACBB__find_volcanoes.asm"
	include "code/ACBC-ACD9__check_teleports.asm"
	include "code/ACDA-AD27__find_rotators.asm"
	include "code/AD28-ADBE__welcome_message.asm"
	include "code/ADBF-ADD1__decode_pass.asm"
	include "code/ADD2-ADF5__decrease_penetrator.asm"
	include "code/ADF6-AE1C__game_finished.asm"


FOUND_SCOTT:
	ABYTEC 0 "YOU HAVE FOUND SCOTT......"

WELL_DONE:
	ABYTEC 0 "WELL DONE."

SCORE_BUFFER:
	DB $00,$00,$00,$00	; digits encoded as nibbles


	include "code/AE45-AE60__increase_score.asm"
	include "code/AE60-AEA5__print_score.asm"


ENERGY:
	DB $00
ENERGY_TMP:
	DB $00


	include "code/AEA8-AF0B__draw_energy.asm"


SLOT.BLINK:
	DB $00,$00
	
CURRENT_WEAPON:
	DB $00
	
WEAPON_TEXT_LEN:
	DB $00

WEAPON_TEXT:
	DB $00,$00
LETTER_SCROLLER:
	DB $00,$00
SCROLLER_STATE:
	DB $00

BUFFER_AF15:
	DB $00,$00,$00,$00,$00,$00
	
BOX.1:
	DB $00,$00,$00,$00,$00,$00,$00,$00

BOX.2:
	DB $00,$00,$00,$00,$00,$00,$00,$00

SLOT.1:		; AF2B
	DB $61,$00,$00,$00
SLOT.2:		; AF2F
	DB $64,$00,$00,$00
SLOT.3:		; AF33
	DB $67,$00,$00,$00
SLOT.4:		; AF37
	DB $6A,$00,$00,$00

X_BUFFER:
	DB $00	; 0  empty
	DB $00	; 1  penetrator
	DB $00	; 2  ultra flash
	DB $00	; 3  mirage
	DB $00	; 4  healer
	DB $01	; 5  jackrabbit
	DB $01	; 6  lifter
	DB $03	; 7  blaster
	DB $02	; 8  backlash
	DB $06	; 9  lava shot
	DB $01	; 10 streamer

BOX.COLORS:
	DB COLOR.BLACK	; 0  empty
	DB COLOR.GREEN	; 1  penetrator
	DB COLOR.RED      ; 2  ultra flash
	DB COLOR.MAGENTA  ; 3  mirage
	DB COLOR.GREEN    ; 4  healer
	DB COLOR.SKYBLUE  ; 5  jackrabbit
	DB COLOR.YELLOW   ; 6  lifter
	DB COLOR.WHITE    ; 7  blaster
	DB COLOR.WHITE    ; 8  backlash
	DB COLOR.RED      ; 9  lava shot
	DB COLOR.MAGENTA  ; 10 streamer
	
ACTIVE_SLOT: 
	DB $00,$00


	include "code/AF53-AF81__show_weapon_slot.asm"
	include "code/AF82-AFF9__message_scroller.asm"
	include "code/AFFA-B023__slot_blinking.asm"
	include "code/B024-B088__show_slot_box.asm"
	include "code/B089-B0FA__select_weapon_slot.asm"


MESSAGE_ADDRESS:
	DB $00,$00
MESSAGE_LENGTH: 
	DB $00
WEAPON_PANEL_FLAG:
	DB $00


	include "code/B0FF-B11A__set_new_message.asm"
	include "code/B11B-B20F__collect_box.asm"
	include "code/B210-B237__consume_ammo.asm"
	include "code/B238-B275__tick_active_weapon.asm"
	include "code/B276-B2C4__stamp_boxes.asm"
	include "code/B2C5-B2F0__restore_boxes.asm"


tick_hazards:
	call check_drowning
	call spawn_alien_at_rotator
	ret


	include "code/B2F8-B33C__check_drowning.asm"
	include "code/B33D-B3E5__spawn_alien_at_rotator.asm"


PLAYER_CELL_LEAD:
	DB $00,$00
PLAYER_CELL_PTR:
	DB $00,$00
	
BLAST_ARMED: 
	DB $00

; --- update_player: per-frame player update - read keys, set facing/velocity/draw offset, then dispatch the action (@done)
update_player:
	ld hl, PLAYFIELD_MAP-1		;LF0BF
	ld bc, $1800
update_player_0:
	DUP 8
		ld (hl), c
		dec l
	EDUP
	djnz update_player_0

; This entry point is used by go_fall and player_standing (.walk).
update_player_1:
	ld a, (PLAYER_Y_COORD)
	add a, $30
	cp $A0
	jr c, update_player_2

	ld a, $FF
	ld (DROWNING), a
update_player_2:
	ld ix, PLAYER
	ld a, (INPUT_LOCK)
	and a
	jp nz, update_player_6

	ld a, (PLAYER)

	cp $05
	jr z, update_player_4

	cp $06
	jr z, update_player_4

	ld (ix+ALIEN.param2), $00
	ld a, (KEY_FIRE_CURRENT)
	bit 1, a
	jr z, update_player_3

	ld (ix+ALIEN.facing), $80
	ld (ix+ALIEN.param2), $FE
update_player_3:
	bit 0, a
	jr z, update_player_4

	ld (ix+ALIEN.facing), $00
	ld (ix+ALIEN.param2), $02
update_player_4:
	call find_player_cell

	ld (ix+ALIEN.draw_x), $00
	ld a, (PLAYER_X_COORD)

	cp $41
	jr nc, update_player_5

	ld (ix+ALIEN.draw_x), $80
update_player_5:
	cp $B2
	jr c, update_player_6

	ld (ix+ALIEN.draw_x), $9D
update_player_6:
	ld a, (PLAYER)

	cp $01
	jp nz, action_by_accum

	ld iy, player_walk
; This entry point is used by the routine at player_standing.
update_player_7:
	ld a, (KEY_FIRE_CURRENT)
	bit 2, a
	jr z, update_player_8

pressed_down:
	ld hl, (PLAYER_CELL_PTR)
	ld a, (hl)

	cp $14
	jp z, go_transfer_room

	cp $15
	jp z, go_transfer_room

	inc hl
	ld a, (hl)

	cp $14
	jp z, go_transfer_room

	cp $15
	jp z, go_transfer_room

	ld a, (LEVEL_NUMBER)
	and a
	jr nz, update_player_8

	ld a, (ROOM_NUMBER)

	cp $28
	jr nz, update_player_8

	ld hl, (PLAYER_CELL_PTR)
	ld de, $0081
	add hl, de
	ld a, (hl)

	cp $1C
	jr nz, update_player_8

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
	jr z, update_player_8
	jp start_teleport

update_player_8:
	jp (iy)

; --- player_walk: ground movement - down=crouch/stairs, up=jump, left/right=walk with wall collision (@done)
player_walk:
	call check_ground
	and a
	jp z, start_fall
	bit 7, (ix+ALIEN.facing)
	jr nz, player_walk_0
	ld hl, (PLAYER_CELL_PTR)
	ld de, $0082
	add hl, de
	call is_solid
	jr c, player_walk_2
	jr player_walk_1
player_walk_0:
	ld hl, (PLAYER_CELL_PTR)
	ld de, $0081
	add hl, de
	call is_solid
	jr c, player_walk_2
player_walk_1:
	ld de, $0020
	add hl, de
	call is_solid
	jr nc, player_walk_2
	ld a, (ix+ALIEN.param2)
	ld (ix+ALIEN.xvel), a
	ld (ix+ALIEN.timer), $02
	ld a, $03
	ld (ix+ALIEN.state), a
	jp action_by_accum

player_walk_2:
	ld a, (KEY_FIRE_CURRENT)
	and $0F
	jr nz, player_walk_3
	ld a, $08
	ld (PLAYER), a
	jp action_by_accum

player_walk_3:
	ld c, a
	bit 2, c
	jr z, player_walk_4
	ld a, (PLAYER_Y_COORD)
	add a, $08
	ld (PLAYER_Y_COORD), a
	ld a, $04
	ld (PLAYER), a
	jp action_by_accum

player_walk_4:
	bit 3, c
	jr z, player_walk_7
	ld iy, (ACTIVE_SLOT)
	ld a, (iy+SLOT.WEAPON)
	cp $05
	jp z, start_fly
	bit 7, (ix+ALIEN.draw_x)
	jr nz, player_walk_6
	ld a, (BLAST_ARMED)
	and a
	jr nz, player_walk_5
	ld hl, (PLAYER_CELL_LEAD)
	call is_solid
	ret c
player_walk_5:
	ld hl, (PLAYER_CELL_PTR)
	ld de, $FFE0		; -32
	add hl, de
	call is_solid
	ret c
	inc l
	call is_solid
	ret c
player_walk_6:
	ld (ix+ALIEN.param1), $F7
	ld a, (ix+ALIEN.param2)
	ld (ix+ALIEN.xvel), a
	ld a, $05
	ld (PLAYER), a
	jp action_by_accum

player_walk_7:
	bit 1, c
	jr z, player_walk_11
	bit 7, (ix+ALIEN.draw_x)
	jr nz, player_walk_10
	ld a, (BLAST_ARMED)
	and a
	jr z, player_walk_8
	ld hl, (PLAYER_CELL_LEAD)
	ld de, $0040
	add hl, de
	call is_solid
	jr c, player_walk_10
	ld de, $0020
	jr player_walk_9
player_walk_8:
	ld hl, (PLAYER_CELL_LEAD)
	call is_solid
	ret c
	ld de, $0020
	add hl, de
	call is_solid
	ret c
	add hl, de
	call is_solid
	ret c
player_walk_9:
	add hl, de
	call is_solid
	jp c, player_recoil

player_walk_10:
	ld a, (PLAYER_X_COORD)
	cp $3B
	jp c, go_left_room

	sub $02
	ld (PLAYER_X_COORD), a

	ret

player_walk_11:
	bit 0, c
	ret z
	bit 7, (ix+ALIEN.draw_x)
	jr nz, player_walk_14
	ld a, (BLAST_ARMED)
	and a
	jr z, player_walk_12
	ld hl, (PLAYER_CELL_LEAD)
	ld de, $0040
	add hl, de
	call is_solid
	jr c, player_walk_14
	ld de, $0020
	jr player_walk_13
player_walk_12:
	ld hl, (PLAYER_CELL_LEAD)
	call is_solid
	ld de, $0020
	add hl, de
	call is_solid
	ret c
	add hl, de
	call is_solid
	ret c
	add hl, de
player_walk_13:
	call is_solid
	jp c, player_recoil
player_walk_14:
	ld a, (PLAYER_X_COORD)
	cp $B6
	jp nc, go_right_room

	add a, $02
	ld (PLAYER_X_COORD), a

	ret


	include "code/B5FD-B628__find_player_cell.asm"


calc_player_map_ptr:
	ld a, (PLAYER_MAP_X)
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
	ld de, PLAYFIELD_MAP
	add hl, de
	ld (PLAYER_CELL_PTR), hl
	ld de, $0080
	add hl, de
	ret

player_recoil:
	ld a, (ix+ALIEN.param2)
	ld (ix+ALIEN.xvel), a
	ld (ix+ALIEN.timer), $02
	ld a, $02
	ld (ix+ALIEN.state), a
	jp action_by_accum


	include "code/B659-B6D7__change_room.asm"


; --- dead_exit4 (DEAD) --------------------------------------------
; @done
; Vestigial 4th-exit handler (unreferenced -> never runs). Reads
; the current room's exit record and tests the unused
; ROOM_EXITS._03 slot, which is always $FF, so it always returns;
; otherwise it would set that as the level and redraw the room.
dead_exit4:
	ld ix, (ROOM_EXITS_ADDR)
	ld a, (ix+ROOM_EXITS._03)
	cp $FF
	ret z

	ld (LEVEL_NUMBER), a
	jp draw_room

; --- start_fall: begin falling (or flying if the Jackrabbit weapon is active) (@done)
start_fall:
	ld iy, (ACTIVE_SLOT)
	ld a, (iy+SLOT.WEAPON)
	cp $05
	jp z, start_fly
	ld a, (ix+ALIEN.param2)
	ld (ix+ALIEN.xvel), a
; entry point used by go_jump.
start_fall_0:
	ld (ix+ALIEN.param1), $01
	ld a, $06
	ld (PLAYER), a
	jp action_by_accum ;LB72D

; --- check_ground: test the two cells under the player for solid ground; returns count in a (@done)
check_ground:
	push de
	push bc
	bit 7, (ix+ALIEN.draw_x)
	jr z, check_ground_0
	call calc_player_map_ptr
	jr check_ground_1
check_ground_0:
	ld hl, (PLAYER_CELL_PTR)
	ld de, $0081
	add hl, de
check_ground_1:
	ld c, $00
	call is_solid
	jr nc, check_ground_2
	inc c
check_ground_2:
	inc l
	call is_solid
	jr nc, check_ground_3
	inc c
check_ground_3:
	ld a, c
	pop bc
	pop de
	ret


	include "code/B72D-B75A__action_by_accum.asm"
	include "code/B75B-B79D__go_stairs.asm"
	include "code/B79E-B7B4__go_sit_down.asm"
	include "code/B7B5-B840__go_jump.asm"
	include "code/B841-B8DD__go_fall.asm"


; --- start_fly: enter the flying state (Jackrabbit) (@done)
start_fly:
	ld (ix+ALIEN.state), $07
	ld (ix+ALIEN.param1), $04
	ret


	include "code/B8E7-B99A__go_fly.asm"
	include "code/B99B-B9B7__player_standing.asm"


; --- player_dying: death state (accum 9) - wait out the timer, flush the screen, lose a life (@done)
player_dying:
	dec (ix+ALIEN.timer)
	ret nz
	call playfield_to_screen
	call playfield_to_screen
	jp lose_life_1


; --- start_teleport: begin the teleport-out dissolve (state $0A, sound 9) (@done)
start_teleport:
	ld (ix+ALIEN.state), $0A
	ld (ix+ALIEN.timer), $32
	ld a, $01
	ld (DISSOLVE), a
	ld a, $09
	call play_sfx
	ret


	include "code/B9D8-BA20__teleport_to_level.asm"
	include "code/BA21-BA67__give_bonus_weapon.asm"


go_appear:
	ld a, $09
	call play_sfx
	ld a, $32  ; duration
	ld (ix+ALIEN.timer), a
	ld a, $04
	ld (DISSOLVE), a
	inc (ix+ALIEN.state)
	ret


; --- finish_appear: materialise state (accum 12) - count the dissolve down, then stand (@done)
finish_appear:
	ld a, (ix+ALIEN.timer)
	and $0F
	jr nz, finish_appear_0
	ld hl, DISSOLVE
	dec (hl)
finish_appear_0:
	dec (ix+ALIEN.timer)
	ret nz
	ld (ix+ALIEN.state), $08
	xor a
	ld (DISSOLVE), a
	ret


	include "code/BA93-BAA6__apply_hazard_damage.asm"


INPUT_LOCK:
	DS $01

; --- lose_life: player death sequence - death sound, freeze, decrement life (@done)
lose_life:
	ld a, $08
	call play_sfx
	ld a, $FF
	ld (INPUT_LOCK), a
	xor a
	ld (DISSOLVE), a
	ld b, $20
lose_life_0:
	push bc
	ld hl, PLAYER_Y_COORD
	inc (hl)
	call animate_playfield
	call draw_all_actors
	pop bc
	djnz lose_life_0

	call playfield_to_screen
	call playfield_to_screen

; This entry point is used by the routines at player_dying and use_weapon.
lose_life_1:
	ld a, (IS_128K)
	ld (RESET_JUMPER_SND), a
	ld a, $02
	ld (SND_TRIG_1), a

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
	jr nz, lose_life_3

	inc hl
	inc de
	djnz loop_hiscore

lose_life_3:
	ld hl, SCORE_BUFFER
	ld de, HISCORE
	ld bc, $0004
	ldir
	jp diagonal_clear


MISS_TERM:
	ABYTEC 0 "MISSION TERMINATED"


	include "code/BB13-BB4B__term_print.asm"
	include "code/BB4C-BB77__check_cheat_password.asm"
	include "code/BB78-BC95__death_explosion.asm"


; --- bullet_hits_alien: bounding-box test of the player's shot vs this alien; sets ALIEN.hit (@done)
bullet_hits_alien:
	ld a, (PLAYER_BULLET)
	and a
	jr z, bullet_hits_alien_0
	ld a, (ix+ALIEN.state)
	and $BF
	jr z, bullet_hits_alien_0
	cp $03
	jr z, bullet_hits_alien_0
	ld a, (BULLET_X)
	add a, $06
	sub (ix+ALIEN.x)
	ld l, a
	ld a, (ix+ALIEN.width)
	add a, a
	add a, a
	add a, $04
	cp l
	jr c, bullet_hits_alien_0
	ld a, (BULLET_Y)
	add a, $0C
	sub (ix+ALIEN.y)
	ld l, a
	ld a, (ix+ALIEN.height)
	add a, a
	add a, a
	add a, a
	add a, $08
	cp l
	jr c, bullet_hits_alien_0
	ld a, (ix+ALIEN.state)
	cp $0A
	jr z, bullet_hits_alien_0
	ld a, (BULLET_HIT)
	ld (ix+ALIEN.hit), a
	and a
	ret
bullet_hits_alien_0:
	or $FF
	ret

; --- fire_weapon: on a fresh fire press, consume ammo and launch the player's bullet (PLAYER_BULLET) (@done)
fire_weapon:
	ld a, (INPUT_LOCK)
	and a
	ret nz
	ld a, (PLAYER)
	cp $0A
	jp z, weapon_release
	ld ix, (ACTIVE_SLOT)
	ld a, (ix+SLOT.WEAPON)
	and a
	ret z
	cp $05
	jp c, use_weapon

	ld a, (KEY_FIRE_CURRENT)
	bit 4, a
	ret z

	ld a, (KEY_FIRE_PREVIOUS)
	bit 4, a
	ret nz

	ld a, (PLAYER_BULLET)
	and a
	ret nz
	ld c, $01
	ld a, (ix+SLOT.WEAPON)
	cp $06
	jr nz, fire_weapon_0
	ld c, $08
fire_weapon_0:
	ld a, c
	call consume_ammo
	jr nc, fire_weapon_1
	ret
fire_weapon_1:
	ld a, (ix+SLOT.WEAPON)
	sub $05
	call play_sfx
	ld iy, PLAYER_BULLET
	ld a, (PLAYER_Y_COORD)
	add a, $05
	ld (BULLET_Y), a
	ld a, (PLAYER_FACING)
	add a, a
	ld a, (PLAYER_X_COORD)
	jr c, fire_weapon_2
	ld e, $06
	ld (iy+ALIEN.facing), $00
	add a, $04
	jr fire_weapon_3
fire_weapon_2:
	ld e, $FA
	ld (iy+ALIEN.facing), $FF
fire_weapon_3:
	add a, $02
	ld (BULLET_X), a
	ld (iy+ALIEN.xvel), e
	ld (iy+ALIEN.state), $01
	ld a, (ix+SLOT.WEAPON)
	sub $05
	ld (iy+ALIEN.anim), a
	ld (iy+ALIEN.base_lo), $E0
	ld (iy+ALIEN.base_hi), $D6
	ld a, (ix+SLOT.POWER)
	ld (iy+ALIEN.hp), a
	ld a, (ix+SLOT.WEAPON)
	cp $06
	jr z, fire_weapon_4
	xor a
	ld (iy+ALIEN.hit), a
	ret
fire_weapon_4:
	or $FF
	ld (iy+ALIEN.hit), a
	ret

; --- reset_bullet: deactivate the player's bullet (PLAYER_BULLET state = 0) (@done)
reset_bullet:
	xor a
	ld (PLAYER_BULLET), a
	ret

; --- move_bullet: advance the player's bullet by its xvel; expire off-screen or on a wall (@done)
move_bullet:
	ld ix, PLAYER_BULLET
	ld a, (ix+ALIEN.x)
	add a, (ix+ALIEN.xvel)
	ld (ix+ALIEN.x), a
	cp $38
	jr c, move_bullet_0
	cp $C4
	jr nc, move_bullet_0
	call alien_hits_wall
	jr c, move_bullet_0
	ret
move_bullet_0:
	ld (ix+ALIEN.state), $00
	ret


	include "code/BDA4-BE0C__use_weapon.asm"


WEAPON_AUTOFIRE:
	DS $01


; --- fire_penetrator: Penetrator weapon fire - start the beam dissolve + sound (@done)
fire_penetrator:
	ld a, (BLAST_ARMED)
	and a
	jr nz, fire_penetrator_0

	ld a, $FF
	ld (BLAST_ARMED), a
	ld a, $07
	call play_sfx
fire_penetrator_0:
	ld a, $02
	ld (DISSOLVE), a
	ld hl, WEAPON_AUTOFIRE
	ld a, (FRAME_PARITY)
	and $01
	add a, (hl)
	ld (hl), $00
	call consume_ammo
	ld a, (ix+SLOT.WEAPON)
	and a
	ret nz
	jp weapon_release


; fire_ultraflash (weapon 2) / fire_weapon3 (weapon 3): no projectile - just return.
fire_ultraflash:
	ret
    

fire_weapon3:
	ret


	include "data/BE3B-BF2A__alien_templates.asm"

	include "code/BF2B-BFD1__choose_alien_routine.asm"
	include "code/BFD2-C04A__do_rockets.asm"
	include "code/C04B-C07D__do_spheres.asm"
	include "code/C07E-C0A5__do_jumpers.asm"
	include "code/C0A6-C0D5__do_mushrooms.asm"


; set while a special alien (harrier) holds slot 1: suppresses normal spawns and keeps
; ALIEN.1 across rooms. Reset per level. (was LC0D6)
BOSS_ACTIVE:
	DB $00
HARRIER_SWEEP: 
	DB $00,$00
	

	include "code/C0D9-C0F7__do_harrier.asm"
	include "code/C0F7-C115__do_bomber.asm"
	include "code/C116-C166__do_volcano.asm"
	include "code/C167-C18B__do_bomb.asm"


kill_all_aliens:
	ld iy, ALIEN.1
	ld de, ALIEN_LEN
	ld b, $06
loop_kill_aliens:
	ld (iy+ALIEN.spawn), $FF
	add iy, de
	djnz loop_kill_aliens

	ret

	include "code/C19E-C1F0__do_mortar.asm"

	DB $00
	DB $00

	include "code/C1F3-C26D__do_snake.asm"

; THEME_PARAM: the active theme's cannon parameter. swap_spritesheet latches it from
; SPRITESET_PARAM[SPRITESET] (the 4-entry table $A7,$64,$56,$3F) on every theme change.
; move_cannon uses it both as the tile it stamps into the cannon's map column and as that
; column's scan length - so each theme's cannon has a different tile/reach. ($A7 = theme 0.)
THEME_PARAM:
	DB $A7



; --- start_vanish --------------------------------------------
; @done
; Turn this alien into its disappearing animation: enter state_vanish
; with a short timer, load the given "disappear" template, play a pop.
; In: ix = alien, hl = disappear template
start_vanish:
	ld (ix+ALIEN.timer), $04
	ld (ix+ALIEN.state), $03
	call copy_alien_template
	call generate_random
	and $03
	add a, $0B
	jp play_sfx


	include "code/C284-C2C0__hit_alien.asm"


; --- award_alien_score ---------------------------------------
; @done
; Add this alien's score value (score_hi:score_lo) to the player
; score. In: ix = alien
award_alien_score:
	ld d, (ix+ALIEN.score_hi)
	ld e, (ix+ALIEN.score_lo)

	jp increase_score


	include "code/C2CA-C2D8__decrease_energy.asm"


; --- alien_hits_player ---------------------------------------
; @done
; Bounding-box overlap test between the player and this alien
; (its box is width*4 x height*8 px from x,y).
; In: ix = alien. Out: zf set = touching player
alien_hits_player:
	ld a, (BLAST_ARMED)
	and a
	jr nz, .no_hit
	ld a, (ix+ALIEN.height)
	add a, a
	add a, a
	add a, a
	ld d, a
	ld a, (ix+ALIEN.width)
	add a, a
	add a, a
	ld e, a
	ld a, (PLAYER_X_COORD)
	sub (ix+ALIEN.x)
	jr nc, .chk_right
	cp $F6
	jr c, .no_hit
	jr .chk_y
.chk_right:
	add a, $04
	cp e
	jr nc, .no_hit
.chk_y:
	ld a, (PLAYER_Y_COORD)
	sub (ix+ALIEN.y)
	jr nc, .chk_bottom
	cp $E4
	jr c, .no_hit
	xor a
	ret
.chk_bottom:
	cp d
	jr nc, .no_hit
	xor a
	ret
.no_hit:
	or $FF
	ret


	include "code/C315-C361__alien_vectors.asm"


; --- move_alien ----------------------------------------------
; @done
; Advance the alien by its velocity: y += yvel, then x += xvel.
; move_alien_x is the x-only entry point. In: ix = alien
move_alien:
	ld a, (ix+ALIEN.y)
	add a, (ix+ALIEN.yvel)
	ld (ix+ALIEN.y), a
; This entry point is used by the routine at move_mushroom.
move_alien_x:
	ld a, (ix+ALIEN.x)
	add a, (ix+ALIEN.xvel)
	ld (ix+ALIEN.x), a
	ret


	include "code/C375-C3A5__move_sphere.asm"
	include "code/C3A6-C3F0__move_rocket.asm"
	include "code/C3F1-C400__state_vanish.asm"


; --- alien_hits_wall -----------------------------------------
; @done
; Test this alien's cell footprint against solid background tiles
; (via is_solid). Honours the noclip flag. In: ix = alien
; Out: cf set = blocked by background
alien_hits_wall:
	ld a, (ix+ALIEN.noclip)
	and a
	ret nz
	ld a, (ix+ALIEN.y)
	and $80
	ret nz
	ld h, a
	ld a, (ix+ALIEN.y)
	and $F8
	ld l, a
	add hl, hl
	add hl, hl
	ld a, (ix+ALIEN.x)
	sub $40
	and a
	ret M
	srl a
	srl a
	ld e, a
	ld d, $00
	add hl, de
	ld de, PLAYFIELD_MAP
	add hl, de
	call is_solid
	ret c
	ld e, l
	ld a, l
	and $1F
	add a, (ix+ALIEN.width)
	cp $20
	ret nc
	ld a, l
	add a, (ix+ALIEN.width)
	dec a
	ld l, a
	call is_solid
	ret c
	ld l, e
	ld de, $0020
	ld b, (ix+ALIEN.height)
.down_loop:
	add hl, de
	djnz .down_loop
	call is_solid
	ret c
	ld a, l
	add a, (ix+ALIEN.width)
	dec a
	ld l, a
	jp is_solid


	include "code/C457-C520__move_cannon.asm"
	include "code/C521-C561__move_cannonball.asm"
	include "code/C562-C5D8__move_jumper.asm"
	include "code/C5D9-C64D__move_mushroom.asm"
	include "code/C64E-C6B6__move_harrier.asm"
	include "code/C6B7-C6B7__just_a_ret.asm"


; --- alien_killed --------------------------------------------
; @done
; The player's weapon hit this alien: award its score and switch
; it to state_rise ($0A) to fly up and vanish. Cannonballs (state 5)
; get param1=$40. In: ix = alien
alien_killed:
	call award_alien_score
	ld a, (ix+ALIEN.state)
	ld (ix+ALIEN.state), $0A
	ld (ix+ALIEN.xvel), $00
	cp $05
	jr z, .set_param1
	ld (ix+ALIEN.param1), $00
	ret


.set_param1:
	ld (ix+ALIEN.param1), $40
	ret


	include "code/C6D4-C6F1__state_rise.asm"
	include "code/C6F2-C73E__move_bomber_bomb.asm"
	include "code/C73F-C788__move_volcano.asm"

	ret	; unreachable padding byte

	include "code/C78A-C7F3__state_bomb.asm"
	include "code/C7F4-C81A__move_bomb.asm"
	include "code/C81B-C85F__move_mortar.asm"
	include "code/C860-C89A__move_mortar_shell.asm"
	include "code/C89B-C921__move_bomber.asm"
	include "code/C922-C97F__state_explosion.asm"
	include "code/C980-C9B7__move_snake_head.asm"
	include "code/C9B8-C9E9__move_snake_body.asm"


; --- toggle_anim_tiles: cycle the animated-tile bytes (water/lava) via the ANIM_TILE_SEQ sequence (@done)
toggle_anim_tiles:
	ld hl, SPRITE_E710
	ld a, (SPRITESET)
	cp $03
	jr nz, .have_bank
	ld hl, SPRITE_E728
.have_bank:
	ld de, ANIM_TILE_SEQ
	ld b, $00
	ld a, $08
.step:
	ld (.count+1), a		; set SMC
	push hl
	ld a, (de)
	bit 7, a
	jr nz, .step_off
	and $07
	dec a
	ld c, a
	add hl, bc
	ld (hl), $FF
	and a
	jr z, .on
	ld (de), a
	jr .next
.on:
	ld a, $80
	ld (de), a
	jr .next
.step_off:
	and $07
	ld c, a
	add hl, bc
	ld (hl), $00
	inc a
	cp $07
	jr z, .off
	or $80
	ld (de), a
	jr .next
.off:
	ld (de), a
.next:
	pop hl
	ld c, $08
	add hl, bc
	inc de
.count:
	ld a, $00		; !!! SMC
	dec a
	jr nz, .step
	ret


ANIM_TILE_SEQ:
	DB $80,$81,$82,$83,$84,$85,$86,$07


	include "code/CA3D-CAAC__move_bridge.asm"


; --- mark_special_tiles --------------------------------------
; @done
; Write $01 into every playfield cell listed in SPECIAL_TILE_LIST
; (built by list_special_tiles), flagging this theme's special tiles.
mark_special_tiles:
	ld hl, SPECIAL_TILE_LIST
	ld a, $01
.loop:
	ld e, (hl)
	inc hl
	ld d, (hl)
	inc hl
	bit 7, d
	ret z

	ld (de), a

	jp .loop


; playfield tile-animation frame counters, advanced by animate_playfield each frame:
; TILE_ANIM1 = 0-7 (water/E400 frames), TILE_ANIM2 = 5..0 down (E630 frames), TILE_ANIM3 =
; 0-11. ANIM_BOUNCE7/6 = triangle-wave (0,1,2,3,2,1,0) frame LUTs. ANIM_TOGGLE = anim state.
TILE_ANIM1:
	DB $00
TILE_ANIM2:
	DB $00
TILE_ANIM3:
	DB $00
ANIM_BOUNCE7:
	DB $00,$01,$02,$03,$02,$01,$00
ANIM_BOUNCE6:
	DB $00,$01,$02,$03,$02,$01


; --- animate_playfield: per-frame playfield animation - special tiles, bridge, water/lava frame counters (@done)
animate_playfield:
	call mark_special_tiles
	call move_bridge
	ld hl, TILE_ANIM1
	ld a, (hl)
	inc a
	and $07
	ld (hl), a
	inc hl
	ld a, (hl)
	dec a
	jp p, .clamp0
	ld a, $05
.clamp0:
	ld (hl), a
	inc hl
	ld a, (hl)
	inc a
	cp $0C
	jr nz, .clamp1
	xor a
.clamp1:
	ld (hl), a
	ld a, (SPRITESET)
	and a
	jr nz, animate_water_lava
	ld a, (TILE_ANIM1)
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
	ld a, (TILE_ANIM2)
	rrca
	rrca
	rrca
	ld e, a
	ld d, $00
	ld hl, SPRITE_E210
	add hl, de
	ld de, SPRITE_E758
	ld bc, $0020
	ldir
	ld a, (TILE_ANIM1)
	add a, a
	add a, a
	add a, a
	add a, a
	ld e, a
	ld d, $00
	ld hl, SPRITE_E460
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
	jp toggle_anim_tiles

; Unused
ANIM_TOGGLE:
	DS $01

; --- animate_water_lava: copy the current animation frame for the water/lava sprites (SPRITE_E400/E630) (@done)
animate_water_lava:
	cp $01
	jp nz, .other
	ld a, (TILE_ANIM1)
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
	ld a, (TILE_ANIM2)
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
	ld a, (ANIM_TOGGLE)
	and a
	jr nz, .swap
	ld a, (TILE_ANIM2)
	cp $05
	jp nz, toggle_anim_tiles
	call generate_random
	and $07
	jp nz, toggle_anim_tiles

.swap:
	ld a, (TILE_ANIM2)
	ld (ANIM_TOGGLE), a
	ld l, a
	ld h, $00
	ld de, ANIM_BOUNCE7
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
	jp toggle_anim_tiles
.other:
	cp $02
	jr nz, .third

	ld a, (TILE_ANIM2)
	ld l, a
	ld h, $00
	ld de, ANIM_BOUNCE6
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
	jp toggle_anim_tiles

.third:
	ld a, (TILE_ANIM3)
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
	ld de, SPRITE_E700
	ld bc, $0020
	ldir
	jp toggle_anim_tiles



diagonal_clear:
	ld sp,STACK
	ei
	call setup_main_menu		; main menu loop
	call new_game	; draw room

.loop:
	call is_fire_pressed	 	; ? inkey
	call update_player		; show player
	call move_bullet	 	; process fire
	call tick_hazards		; ? drowning
	call hit_alien
	call fire_weapon		; ? use weapon
	call select_weapon_slot		; ? switch weapon
	call print_score

	ld a, (DROWNING)

	IFNDEF WATERPROOF
		and a
	ELSE
		xor a
	ENDIF

	jp nz, lose_life

	ld a, (ENERGY)
	and a
	jr nz, .refresh

	ld a, (PLAYER)

	cp $09
	jr z, .refresh

	ld a, $09
	ld (PLAYER), a
	ld a, $32
	ld (PLAYER_FRAME_COUNT), a
	ld a, $01
	ld (DISSOLVE), a
	ld (INPUT_LOCK), a
.refresh:
	call draw_energy
	call show_weapon_slot
	call animate_playfield
	call draw_all_actors			; draw energy and loot
	ld hl, SLOT.BLINK
	inc (hl)
	ld hl, FRAME_PARITY
	ld a, (hl)
	add a, $01
	daa
	ld (hl), a
	jp .loop


	include "data/CC5C-CD5F__menu_icons.asm"
	include "data/CD60-CDDF__sprites_player_01.asm"
	include "data/CDE0-CE5F__sprites_player_02.asm"
	include "data/CE60-CEDF__sprites_player_03.asm"
	include "data/CEE0-CF5F__sprites_player_04.asm"
	include "data/CF60-CFDF__sprites_player_05.asm"
	include "data/CFE0-D05F__sprites_player_06.asm"
	include "data/D060-D0DF__sprites_player_07.asm"
	include "data/D0E0-D15F__sprites_player_08.asm"
	include "data/D160-D1DF__sprites_player_09.asm"
	include "data/D1E0-D25F__sprites_player_10.asm"
	include "data/D260-D39F__sprites.asm"
	include "data/D3A0-D43F__font_big.asm"
	include "data/D440-D57F__sprites.asm"
	include "data/D580-D6DF__sprites_weapons.asm"
	include "data/D6E0-D79F__sprites_bullets.asm"
	include "data/D7A0-D97F__sprites.asm"
	include "data/D980-DBBF__sprites.asm"
	include "data/DBC0-E7FF__sprites.asm"
	include "data/E800-EDFF__particles.asm"
	include "data/EE00-EEFF__colors_player.asm"
	include "data/EF00-EFFF__colors_backgr.asm" 

	include "data/F000-F5FF__work_buffers.asm"
	include "data/F600-F7FF__multicolor_luts.asm"
	include "data/F800-FCFF__color_luts.asm"
	include "data/FD00-FDFF__attr_color_lut.asm"


INT_VECTORS:	; must be aligned
	DS $100, 0

	include "data/FF00-FFF3__boot_loader.asm"

to_interrupt:
	jp interrupt

	DB $5A,$A5,$80,$E2,$88,$E2,$3C
	
; IS_128K: machine flag set by the loader (0 = 48K, $FF = 128K)
IS_128K:
	DB $FF


last_jump:
	DB $18	; jr to_interrupt

	savebin "recompile/mask_3_loaded.bin",STARTBLOCK,$FFFF-STARTBLOCK+1		; md5 check: 19bc11db626363a574876062784c5294
	savesna "recompile/mask_3_loaded.sna",startup							; md5 check: 0c6b5a5f7109c6b0f5bf446cbb51affd
