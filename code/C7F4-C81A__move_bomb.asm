; --- move_bomb -------------------------------------------------
; @done
; Bomb movement: fall or rise per the sign of its yvel; explode on
; impact.
; In: ix = bomb alien
move_bomb:
	ld a, (ix+ALIEN.yvel)		; bomb speed A4A7
	and a
	jp m, bomb_up

bomd_down:
	add a, (ix+ALIEN.y)		; bomb y-coord A48F
	ld (ix+ALIEN.y), a
	add a, $20
	cp $76
	ret c

	ld (ix+ALIEN.yvel), $FC	; -4
	ret

bomb_up:
	add a, (ix+ALIEN.y)
	ld (ix+ALIEN.y), a
	add a, $20
	cp $40
	ret nc

	ld (ix+ALIEN.yvel), $04	; +4

	ret
