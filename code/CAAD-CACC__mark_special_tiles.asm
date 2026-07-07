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
