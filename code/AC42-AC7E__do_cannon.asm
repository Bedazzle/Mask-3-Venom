; --- do_cannon -------------------------------------------------
; @done
; Fire the room cannon (unless the harrier boss is active): launch
; a cannonball alien from the cannon tile.
do_cannon:
	ld a, (BOSS_ACTIVE)
	and a
	ret nz

	ld a, $12
	call find_room_tile
	ret z

	ld ix, ALIEN.1
loop_cannon:
	ld (ix+ALIEN.x),B
	ld a, c
	sub $02
	ld a, c
	ld (ix+ALIEN.y), a
	ld (ix+ALIEN.state), $04
	ld (ix+ALIEN.yvel), $00
	exx
	ld (ix+ALIEN.param1), l
	ld (ix+ALIEN.param2), h
	exx
	
	ld hl, TEMPLATE_CANNON

	call copy_alien_template

	ld (ix+ALIEN_LEN+ALIEN.state), $40

	call find_room_tile_next
	ret z

	ld ix, ALIEN.3

	jr loop_cannon
