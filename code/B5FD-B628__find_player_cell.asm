; --- find_player_cell -----------------------------------------
; @done
; Compute the playfield-map (PLAYFIELD_MAP buffer) address of the cell
; the player currently occupies, from PLAYER_X_COORD /
; PLAYER_Y_COORD, plus the cell offset in the facing direction,
; and read the tile at that leading cell.
; In:  ix = player record (bit 7 of ix+$02 = facing flag)
; Out: (PLAYER_CELL_PTR) = cell under player, (PLAYER_CELL_LEAD) = leading cell,
;      hl = leading cell addr, a = tile there
; Note: map stride is 32; +3 when not facing (PLAYER_WIDTH-1)
find_player_cell:
	ld a, (PLAYER_X_COORD)
	sub $3C			; 60 = left playfield margin
	rrca
	rrca
	and $1F
	ld e, a			; e = column 0..31
	ld d, $00
	ld a, (PLAYER_Y_COORD)
	and $F8			; snap to char row

	ld l, a
	ld h, d
	add hl, hl		; x2
	add hl, hl		; x4 -> (y>>3)*32
	add hl, de
	ld de, PLAYFIELD_MAP-1
	add hl, de

	ld (PLAYER_CELL_PTR), hl		; cell under player
	bit 7, (ix+ALIEN.facing)		; facing?
	jr nz, .no_offset

	ld de, $0003
	add hl, de		; step to leading cell

.no_offset:
	ld (PLAYER_CELL_LEAD), hl		; leading cell
	ld a, (hl)

	ret
