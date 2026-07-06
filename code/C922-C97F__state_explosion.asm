; --- state_explosion (alien state, vector 17) ----------------
; @done
; Timed explosion (entered via become_explosion): spawn random
; disappear effects near param1/param2 until the timer expires.
; In: ix = alien
state_explosion:
	dec (ix+ALIEN.timer)
	jr nz, .spawn

	ld (ix+ALIEN.state), $00

	ret

.spawn:
	call generate_random

	and $0F
	sub $02
	add a, (ix+ALIEN.param1)
	ld l, a

	call generate_random

	and $0F
	sub $04
	add a, (ix+ALIEN.param2)
	ld h, a
	ld ix, ALIEN.1
	ld de, ALIEN_LEN
	ld b,$06

.find_slot:
	ld a, (ix+ALIEN.state)
	and $3F
	jr z, .place

	add ix, de
	djnz .find_slot

	ret


.place:
	ld (ix+ALIEN.x), l
	ld (ix+ALIEN.y), h

	call generate_random

	and $03
	bit $01, a
	jr z, .pick_bomb

	ld hl, VANISH_SMALL
	bit $00, a
	jr z, .do_small

	ld hl, VANISH_MED

.do_small:
	jp start_vanish


.pick_bomb:
	ld hl, VANISH_BOMB1
	bit $00, a
	jr z, .do_bomb

	ld hl, VANISH_BOMB2

.do_bomb:
	jp start_vanish
