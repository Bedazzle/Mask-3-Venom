; --- alien_hits_player ---------------------------------------
; @done
; Bounding-box overlap test between the player and this alien
; (its box is width*4 x height*8 px from x,y).
; In: ix = alien. Out: zf set = touching player
alien_hits_player:
	ld a, (BLAST_ARMED)
	and a
	jr nz, .no_hit
	ld a, (ix+ALIEN.height)
	add a, a
	add a, a
	add a, a
	ld d, a
	ld a, (ix+ALIEN.width)
	add a, a
	add a, a
	ld e, a
	ld a, (PLAYER_X_COORD)
	sub (ix+ALIEN.x)
	jr nc, .chk_right
	cp $F6
	jr c, .no_hit
	jr .chk_y
.chk_right:
	add a, $04
	cp e
	jr nc, .no_hit
.chk_y:
	ld a, (PLAYER_Y_COORD)
	sub (ix+ALIEN.y)
	jr nc, .chk_bottom
	cp $E4
	jr c, .no_hit
	xor a
	ret
.chk_bottom:
	cp d
	jr nc, .no_hit
	xor a
	ret
.no_hit:
	or $FF
	ret
