ROOM_BACKGR_ADDR:
	defb $00,$00
CURRENT_LEVEL:
	defb $00

	
LA89D:
	ld a, (LEVEL_NUMBER)
	cp $0F
	jr nz, LA8AC

	ld a, (ROOM_NUMBER)

	cp $28
	jp z, game_finished

	;;; level draw start ?

LA8AC:
	xor a
	ld (LA2CE), a

	ld a, (LEVEL_NUMBER)
	ld hl, CURRENT_LEVEL

	cp (hl)
	ld (hl), a
	jr z, LA89D_1

	xor a
	ld (LC0D6), a
LA89D_1:
	call LBD7F

	ld ix, ALIEN.1
	ld de, $0026	; 38
	ld b, $06
	ld a, (LC0D6)
	and a
	jr z, LA89D_2

	add ix, de
	dec b
LA89D_2:
	ld (ix+$00), $00
	ld (ix+$1F), $00
	add ix, de
	djnz LA89D_2

	; start blocks to buffer extract
	ld de, LF080
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
	jr nc, LA89D_3

	inc h

LA89D_3:
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
	jr nc, LA96B

	inc d

LA96B:
	exx
	add hl, de
	dec c
	jp nz, loop_room_rows
	; end blocks to buffer extract

	ld ix, (ROOM_EXITS_ADDR)
	ld a, (ix+$04)

	call swap_spritesheet

	ld hl, PLAYFIELD	; clear playfield F3C0-F600
	ld de, PLAYFIELD+1
	ld bc, 32*18-1		; 575
	ld (hl), $01
	ldir
	
	call playfield_to_screen

	ld hl, (ROOM_EXITS_ADDR)
	ld de, $0006
	add hl, de
	ld a, (ROOM_NUMBER)
	rrca
	rrca
	rrca
	ld e, a
	add hl, de
	ld a, (hl)
	
L_A99B:
	ld (LBFB0), a
	
	; level draw end ?
	
	call decrease_penetrator
	call LAB6B
	call LAA75
	call do_cannon
	call LACA0
	call LACEA
	call LAC80
	call draw_boxes

	ld a, $FF
	ld (L946D), a

	jp welcome_message
