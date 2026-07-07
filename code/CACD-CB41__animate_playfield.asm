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
