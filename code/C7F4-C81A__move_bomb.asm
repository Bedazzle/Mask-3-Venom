move_bomb:
	ld a, (ix+$1C)		; bomb speed A4A7
	and a
	jp m, bomb_up

bomd_down:
	add a, (ix+$04)		; bomb y-coord A48F
	ld (ix+$04), a
	add a, $20
	cp $76
	ret c

	ld (ix+$1C), $FC	; -4
	ret

bomb_up:
	add a, (ix+$04)
	ld (ix+$04), a
	add a, $20
	cp $40
	ret nc

	ld (ix+$1C), $04	; +4

	ret
