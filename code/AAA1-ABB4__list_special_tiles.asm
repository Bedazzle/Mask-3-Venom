SPECIAL_TILE_LIST:
	DS $C0,$00
	DB $00,$00
	DB $00,$00
	DB $00,$00
	DB $00,$00
	
SPECIAL_TILE_PTR:
	DB $00,$00


; --- list_special_tiles --------------------------------------
; @done
; Scan the room map (PLAYFIELD_MAP) for the tile codes in this theme's
; table (SPECIAL_TILE_TABLES indexed by SPRITESET) and record each
; matching cell's playfield address into SPECIAL_TILE_LIST
; (0-terminated). mark_special_tiles later flags them. From draw_room.
list_special_tiles:
	ld hl, SPECIAL_TILE_TABLES
	ld a, (SPRITESET)
	add a, a
	ld e, a
	ld d, $00
	add hl, de
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	ld (.cell_start+1), hl	; set SMC

	ld hl, SPECIAL_TILE_LIST
	ld (SPECIAL_TILE_PTR), hl

	ld hl, PLAYFIELD_MAP
	ld bc, $0240

.cell_start:
	ld de, $0000		; !!! SMC

.match:
	ld a, (de)
	and a
	jr z, .advance

	cp (hl)
	jr z, .record
	jr nc, .advance

	inc de
	jr .match

.record:
	ld de, (SPECIAL_TILE_PTR)
	ld a, l
	ld (de), a
	inc de
	ld a, h
	add a, $03
	ld (de), a
	inc de
	ld (SPECIAL_TILE_PTR), de

.advance:
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .cell_start

	ld hl, (SPECIAL_TILE_PTR)
	inc hl
	ld (hl), $00

	ret
