; --- calc_player_map_ptr: compute PLAYER_CELL_PTR from PLAYER_MAP_X / PLAYER_Y_COORD (@done)
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
