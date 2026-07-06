ROOM_BACKGR_ADDR:
	DB $00,$00
CURRENT_LEVEL:
	DB $00

	
; --- draw_room -----------------------------------------------
; @done
; Load and draw the current room (LEVEL_NUMBER, ROOM_NUMBER). Ends
; the game on the final room; resets per-room alien slots; derives
; ROOM_EXITS_ADDR (ROOMS_EXITS + level*12) and ROOM_BACKGR_ADDR
; (ROOMS_LANDSCAPE + level*240 + room); expands the 8x5 tile grid
; (each code -> a 4x4 cell block via BACKGR_TILES) into the map
; buffer; swaps the theme spritesheet; clears + shows the
; playfield; picks the room's alien set; then runs every per-room
; setup (bridge, cannon, volcanoes, rotators, boxes) and the
; welcome banner.
; Entry point for new_game / change_room / teleport_to_level.
draw_room:
	ld a, (LEVEL_NUMBER)
	cp $0F
	jr nz, .draw_start

	ld a, (ROOM_NUMBER)

	cp $28
	jp z, game_finished

	;;; level draw start ?

.draw_start:
	xor a
	ld (DRAW_COLOR_BASE), a

	ld a, (LEVEL_NUMBER)
	ld hl, CURRENT_LEVEL

	cp (hl)
	ld (hl), a
	jr z, .same_level

	xor a
	ld (BOSS_ACTIVE), a
.same_level:
	call reset_bullet

	ld ix, ALIEN.1
	ld de, ALIEN_LEN	; 38
	ld b, $06
	ld a, (BOSS_ACTIVE)
	and a
	jr z, .clear_aliens

	add ix, de
	dec b
.clear_aliens:
	ld (ix+ALIEN.state), $00
	ld (ix+ALIEN.spawn), $00
	add ix, de
	djnz .clear_aliens

	; start blocks to buffer extract
	ld de, ROOM_BLOCKS
	exx
	ld a, (LEVEL_NUMBER)
	; mult
	ld l, a
	ld h, $00
	ld e, l
	ld d, h
	add hl, hl	; x2
	add hl, de	; x3
	add hl, hl	; x6
	add hl, hl	; x12
	ld de, ROOMS_EXITS
	add hl, de
	; mult HL = ROOMS_EXITS + A*12
	ld (ROOM_EXITS_ADDR), hl

	;mult
	ld l, a
	ld h, $00
	ld e, l
	ld d, h
	add hl, hl	; x2
	add hl, de	; x3
	add hl, hl	; x6
	add hl, de	; x7
	add hl, hl	; x14
	add hl, de	; x15
	add hl, hl	; x30
	add hl, hl	; x60
	add hl, hl	; x120
	add hl, hl	; x240
	ld de, ROOMS_LANDSCAPE
	add hl, de
	; mult HL = A*240+30208

	ld a, (ROOM_NUMBER)
	add a, l
	ld l, a
	jr nc, .have_room

	inc h

.have_room:
	ld (ROOM_BACKGR_ADDR), hl
	ld de, $0028	; 8x5=40 cells
	ld c, $05		; room rows
loop_room_rows:
	ld b, $08		; room columns

loop_room_cols:
	ld a, (hl)
	exx
	;mult
	ld l, a
	ld h, $00
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, hl	; x8
	add hl, hl	; x16	one sprite is 4x4=16 cells
	ld bc, BACKGR_TILES
	add hl, bc
	; mult HL=A*16 + BACKGR_TILES
	ldi
	ldi
	ldi
	ldi
	push de

	DUP 3
	 ld a, $1C ;28
	 add a, e
	 ld e, a
	 jr nc, 1F
	 inc d
1:
	 ldi
	 ldi
	 ldi
	 ldi
	EDUP

	pop de
	exx
	inc hl
	djnz loop_room_cols

	exx
	ld a, $60
	add a, e
	ld e, a
	jr nc, .row_done

	inc d

.row_done:
	exx
	add hl, de
	dec c
	jp nz, loop_room_rows
	; end blocks to buffer extract

	ld ix, (ROOM_EXITS_ADDR)
	ld a, (ix+ROOM_EXITS.THEME)

	call swap_spritesheet

	ld hl, PLAYFIELD	; clear playfield F3C0-F600
	ld de, PLAYFIELD+1
	ld bc, 32*18-1		; 575
	ld (hl), $01
	ldir
	
	call playfield_to_screen

	ld hl, (ROOM_EXITS_ADDR)
	ld de, ROOM_EXITS.ALIEN_SET
	add hl, de
	ld a, (ROOM_NUMBER)
	rrca
	rrca
	rrca
	ld e, a
	add hl, de
	ld a, (hl)
	
.set_aliens:
	ld (ROOM_ALIEN_SET), a
	
	; level draw end ?
	
	call decrease_penetrator
	call list_special_tiles
	call find_bridge
	call do_cannon
	call find_volcanoes
	call find_rotators
	call find_ground_row
	call draw_boxes

	ld a, $FF
	ld (RESET_VOLCANO_SND), a

	jp welcome_message
