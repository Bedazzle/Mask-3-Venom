; --- draw_sprite ---------------------------------------------
; @done
; Render one multicolour sprite into the playfield/attribute
; buffers. Computes the destination from x,y, lays down the
; background tiles + colour attributes the sprite covers, then
; (mirror_sprite if facing-left) + expand_sprite prepares the
; graphics and it is mask-composited in. Handles both cell-aligned
; and horizontally-shifted (x & 3) positions.
; In: ix = actor, iy = colour buffer cursor
draw_sprite:
	ld a, (ix+ALIEN.y)
	add a, $30
	and $F8
	ld (ix+ALIEN.draw_cy), a
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld a, (ix+ALIEN.x)
	sub $40
	ld (ix+ALIEN.draw_x), a
	sra a
	sra a
	ld e, a
	ld d, $00
	add a, a
	jr nc, .neg_x

	ld d, $FF
.neg_x:
	add hl, de
	ld de, DATA_BLOCK1
	add hl, de
	ld (ix+ALIEN.buf_hi), h
	ld (ix+ALIEN.buf_lo), l
	ld a, (DRAW_COLOR)
	ld (ix+ALIEN.attr), a
	ld b, a
	exx
	ld l, a
	ld h, high ATTR_COLOR_LUT		; $FD
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, hl	; x8	HL = $FD00 + A*8
	push hl
	ex de, hl
	exx
	ld de, (DRAW_DEST)
	ld (ix+ALIEN.map_lo), e
	ld (ix+ALIEN.map_hi), d
	ld a, (ix+ALIEN.width)
	inc a
	ld (ix+ALIEN.col_cnt), a
.col:
	push hl
	ld a, (ix+ALIEN.draw_cy)
	ld (ix+ALIEN.draw_cx), a
	ld a, (ix+ALIEN.height)
	inc a
.row:
	push af
	push de
	ld d, high COLORS_BACKGR		; $EF
	ld e, (hl)
	ld a, h
	inc h
	inc h
	inc h
	bit 1, (hl)
	jr z, .use_player

	ld d, high COLORS_PLAYER		; $EE
.use_player:
	ld h, a
	ld a, (de)
	and a
	jr nz, .have_color

	ld a, (ix+ALIEN.color)
.have_color:
	ld (iy+$00), a
	inc iy
	pop de
	ld a, (hl)
	ld (de), a

	cp $EA
	jp nc, .offscreen

	bit 7, (ix+ALIEN.draw_x)
	jr nz, .offscreen

	ex af, af'
	ld a, (ix+ALIEN.draw_cx)

	cp $C0
	jr nc, .offscreen

	ex af, af'
	ld (hl), b
	inc de
	inc b
	inc h
	inc h
	inc h
	ld c, (hl)
	ld (hl), $02
	bit 1, c
	exx
	ld l, a
	ld h, high COLOR_LUT		; $FC
	jr z, .copy8

	ld h, high ATTR_COLOR_LUT		; $FD
.copy8:
	add hl, hl	; x2
	add hl, hl	; x4
	add hl, hl	; x8	HL = (COLOR_LUT ~ ATTR_COLOR_LUT) + A*8

	DUP 8
		ldi
	EDUP

	exx
	dec h
	dec h
	ld a, l
	add a, $20
	ld l, a
	jr c, .next_row

	dec h
.next_row:
	ld a, (ix+ALIEN.draw_cx)
	add a, $08
	ld (ix+ALIEN.draw_cx), a
	pop af
	dec a
	jp nz, .row

	pop hl
	inc hl
	ld a, (ix+ALIEN.draw_x)
	add a, $04
	ld (ix+ALIEN.draw_x), a
	dec (ix+ALIEN.col_cnt)
	jp nz, .col

	ld a, b
	ld (DRAW_COLOR), a
	ld (DRAW_DEST), de
	jp .composite

.offscreen:
	exx
	ld a, e
	add a, $08
	ld e, a
	jp nc, .offscreen2

	inc d
.offscreen2:
	exx
	inc de
	inc b
	ld a, l
	add a, $20
	ld l, a
	jp nc, .next_row

	inc h
	jp .next_row

.composite:
	bit 7, (ix+ALIEN.facing)

	call nz, mirror_sprite
	call expand_sprite

	pop hl
	ld a, (ix+ALIEN.y)
	and $07
	ld e, a
	ld d, $00
	add hl, de
	ld a, (ix+ALIEN.x)
	and $03
	jp nz, .shifted

	ld bc, DATA_BLOCK1
	ld e, (ix+ALIEN.spr_lo)
	ld d, (ix+ALIEN.spr_hi)
	ld a, (ix+ALIEN.width)
	ld (ix+ALIEN.col_cnt), a

.al_col:
	ld a, (ix+ALIEN.height)

.al_row:
	ex af, af'

	DUP 7
		ld a, (bc)
		inc c
		cpl
		and (hl)
		ex de, hl
		or (hl)
		inc l
		ex de, hl
		ld (hl), a
		inc hl
	EDUP
	
	ld a, (bc)
	inc c
	cpl
	and (hl)
	ex de, hl
	or (hl)
	inc hl			; !!!
	ex de, hl
	ld (hl), a
	inc hl

	ex af, af'
	dec a
	jr nz, .al_row

	ld a, l
	add a, $08
	ld l, a
	jp nc, .al_next

	inc h
.al_next:
	dec (ix+ALIEN.col_cnt)
	jp nz, .al_col

	ret

.shifted:
	add a, a
	add a, $F6
	ld d, a
	ld a, (ix+ALIEN.height)
	inc a
	add a, a
	add a, a
	add a, a
	ld c, a
	ld b, $00
	ld a, d
	exx
	ld h, a
	ld de, DATA_BLOCK1
	ld c, (ix+ALIEN.spr_lo)
	ld b, (ix+ALIEN.spr_hi)
	ld a, (ix+ALIEN.width)
	ld (ix+ALIEN.col_cnt), a

.sh_col:
	ld a, (ix+ALIEN.height)
	ld (ix+ALIEN.row_cnt), a

.sh_row:
	ld a, $04

.sh_bits:
	ex af, af'

	ld a, (bc)
	inc c
	ld l, a
	ld a, (de)
	inc e
	exx
	ld e, a
	ld a, (de)
	cpl
	and (hl)
	exx
	or (hl)
	exx
	ld (hl), a
	add hl, bc
	inc d
	ld a, (de)
	cpl
	and (hl)
	exx
	inc h
	or (hl)
	exx
	ld (hl), a
	inc hl
	exx

	ld a, (bc)
	inc bc		; !!!
	ld l, a
	ld a, (de)
	inc e
	exx
	ld e, a
	ld a, (de)
	cpl
	and (hl)
	exx
	or (hl)
	exx
	ld (hl), a
	sbc hl, bc	; !!!
	dec d		; !!!
	ld a, (de)
	cpl
	and (hl)
	exx
	dec h		; !!!
	or (hl)
	exx
	ld (hl), a
	inc hl
	exx

	ex af, af'
	dec a
	jp nz, .sh_bits

	dec (ix+ALIEN.row_cnt)
	jp nz, .sh_row

	exx
	ld a, l
	add a, $08
	ld l, a
	jr nc, .sh_next

	inc h
.sh_next:
	exx
	dec (ix+ALIEN.col_cnt)
	jp nz, .sh_col

	ret
