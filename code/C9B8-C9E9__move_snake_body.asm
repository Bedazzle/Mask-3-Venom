; --- move_snake_body (alien state, vector 19) ----------------
; @done
; Trailing snake segment: follow the segment ahead; when it
; reaches x < $38, respawn the whole alien wave (state $80).
; In: ix = alien
move_snake_body:
	ld a, (ix+ALIEN.y)
	ld (ix+ALIEN.yvel), a
	ld a, (ix-10)
	ld (ix+ALIEN.y), a
	dec (ix+ALIEN.x)

	call alien_hits_player
	call z, decrease_energy

	ld a, (ix+ALIEN.xvel)
	and a
	ret z

	ld a, (ix+ALIEN.x)
	cp $38
	ret nc

	ld ix, ALIEN.1
	ld de, ALIEN_LEN
	ld b, $06

.shift_loop:
	ld (ix+ALIEN.state), $80
	add ix, de
	djnz .shift_loop

	ret
