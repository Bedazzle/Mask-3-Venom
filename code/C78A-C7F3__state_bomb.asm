; --- state_bomb (alien state, vector 13) ---------------------
; @done
; The smart-bomb alien: move (move_bomb), seed a follow-up
; explosion in the neighbour record, and detonate after ~10
; hit-frames. In: ix = alien
state_bomb:
	ld a, (ix+ALIEN.hit)
	and a
	jr z, .alive

	inc (ix+ALIEN.param1)
	ld a, (ix+ALIEN.param1)

	cp $0A
	jp z, alien_killed

.alive:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .explode

	call move_bomb

	call alien_hits_player
	ret nz

	call decrease_energy

.explode:
	call award_alien_score

	ld a, (ix+ALIEN.x)
	sub $04
	ld (ix+ALIEN.x), a
	ld a, (ix+ALIEN.y)
	add a, $04
	ld (ix+ALIEN.y), a

	ld hl, VANISH_BOMB1		; bomb disappearing 1
	call start_vanish

	ld (ix+ALIEN.timer), $08
	ld a, (ix+ALIEN.index)

	cp $06
	ret z

	ld a, (ix+ALIEN_LEN+ALIEN.state)
	and $3F
	ret nz

	ld a, (ix+ALIEN.x)
	add a, $0C
	ld (ix+ALIEN_LEN+ALIEN.x), a
	ld a, (ix+ALIEN.y)
	add a, $04
	ld (ix+ALIEN_LEN+ALIEN.y), a
	ld de, ALIEN_LEN
	add ix, de

	ld hl, VANISH_BOMB2		; bomb disappearing 2
	call start_vanish

	ld (ix+ALIEN.timer), $0C

	ret
