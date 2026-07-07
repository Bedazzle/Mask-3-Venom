; --- alien_hits_wall -----------------------------------------
; @done
; Test this alien's cell footprint against solid background tiles
; (via is_solid). Honours the noclip flag. In: ix = alien
; Out: cf set = blocked by background
alien_hits_wall:
	ld a, (ix+ALIEN.noclip)
	and a
	ret nz
	ld a, (ix+ALIEN.y)
	and $80
	ret nz
	ld h, a
	ld a, (ix+ALIEN.y)
	and $F8
	ld l, a
	add hl, hl
	add hl, hl
	ld a, (ix+ALIEN.x)
	sub $40
	and a
	ret M
	srl a
	srl a
	ld e, a
	ld d, $00
	add hl, de
	ld de, PLAYFIELD_MAP
	add hl, de
	call is_solid
	ret c
	ld e, l
	ld a, l
	and $1F
	add a, (ix+ALIEN.width)
	cp $20
	ret nc
	ld a, l
	add a, (ix+ALIEN.width)
	dec a
	ld l, a
	call is_solid
	ret c
	ld l, e
	ld de, $0020
	ld b, (ix+ALIEN.height)
.down_loop:
	add hl, de
	djnz .down_loop
	call is_solid
	ret c
	ld a, l
	add a, (ix+ALIEN.width)
	dec a
	ld l, a
	jp is_solid
