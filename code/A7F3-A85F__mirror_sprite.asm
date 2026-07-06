; --- mirror_sprite -------------------------------------------
; @done
; Build the horizontally-mirrored copy of the sprite (facing left)
; into the MIRROR_BUFFER buffer via the $F600 table, walking columns in
; reverse (SMC row stride). In: ix = actor (uses ALIEN.spr, w, h)
mirror_sprite:
	ld a, (ix+ALIEN.height)
	add a, a
	add a, a
	add a, a
	ld e, a
	ld d, $00
	ld h, (ix+ALIEN.spr_hi)
	ld l, (ix+ALIEN.spr_lo)
	ld a, (ix+ALIEN.width)

.skip_col:
	dec a
	jr z, .setup

	add hl, de
	jp .skip_col

.setup:
	ld a, e
	neg
	ld (.row_step+1), a     ; set SMC
	ld de, MIRROR_BUFFER
	ld (ix+ALIEN.spr_hi), d
	ld (ix+ALIEN.spr_lo), e
	ld b, $F6
	exx
	ld c, (ix+ALIEN.width)

.col:
	exx
	ld a, (ix+ALIEN.height)

.row:
	ex af, af'

	DUP 7
		ld c, (hl)
		ld a, (bc)
		ld (de), a
		inc l
		inc e
	EDUP

	; -----------
		ld c, (hl)
		ld a, (bc)
		ld (de), a
		inc hl		; !!!
		inc de		; !!!
	; -----------

	ex af, af'
	dec a
	jp nz, .row

.row_step:
	ld bc, tape_loader		; !!! SMC
	add hl, bc
	add hl, bc
	ld b, $F6
	exx
	dec c
	jp nz, .col

	ret
