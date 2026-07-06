; --- draw_all_actors -----------------------------------------
; @done
; Master actor renderer, one call per frame. Stamps the box
; overlays, renders each active player/object record (PLAYER x8)
; via pick_actor_sprite + draw_sprite into the playfield buffer,
; flushes it to screen (playfield_to_screen), then composites the
; six pre-rendered alien buffers (ALIEN.buf -> ALIEN.map). Finally
; restores the box backgrounds (restore_boxes).
draw_all_actors:
	call stamp_boxes

	ld a, (DRAW_COLOR_BASE)
	ld (DRAW_COLOR), a

	ld e, a
	ld d, $00
	ld iy, COLORS_PLAYER
	add iy, de
	ld ix, PLAYER
	ld b, $08

.player_loop:
	ld a, (ix+ALIEN.state)
	and $BF
	jr z, .next_player

	push bc

	call pick_actor_sprite
	call draw_sprite

	pop bc

.next_player:
	ld de, ALIEN_LEN
	add ix, de
	djnz .player_loop

	call playfield_to_screen

	ld ix, ALIEN.6
	ld a, $08

.alien_loop:
	push af
	ld a, (ix+ALIEN.state)
	and $BF
	jr z, .next_alien

	ld de, $0020
	ld c, (ix+ALIEN.map_lo)
	ld b, (ix+ALIEN.map_hi)
	ld h, (ix+ALIEN.buf_hi)
	ld l, (ix+ALIEN.buf_lo)
	ld a, (ix+ALIEN.width)
	inc a
	ld (ix+ALIEN.col_cnt), a

.blit_col:
	ld a, (ix+ALIEN.height)
	inc a
	push hl

.blit_row:
	ex af, af'
	ld a, (bc)
	inc bc
	ld (hl), a
	add hl, de
	ex af, af'
	dec a
	jp nz, .blit_row

	pop hl
	inc hl
	dec (ix+ALIEN.col_cnt)
	jp nz, .blit_col

.next_alien:
	pop af
	ld de, -ALIEN_LEN	; -38
	add ix, de
	dec a
	jp nz, .alien_loop

	jp restore_boxes
