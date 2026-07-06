; --- move_bomber (alien state, vector 16) --------------------
; @done
; Bomber: fly left dropping bombs (state 11) into free records;
; falls through to become_explosion (state 17) when done.
; In: ix = alien
move_bomber:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .score

	ld a, (ix+ALIEN.x)
	sub $02
	ld (ix+ALIEN.x), a

	cp $DC
	ld a, $0A

	call z, play_sfx
	call generate_random

	and $92
	jr nz, .check_hit

	ld h, (ix+ALIEN.y)
	ld l, (ix+ALIEN.x)
	ld a, l
	sub $40
	jp m, .check_hit

	push ix
	ld ix, ALIEN.1
	ld de, ALIEN_LEN
	ld b, 6

.find_slot:
	ld a, (ix+ALIEN.state)
	and $3F
	jr z, .drop_bomb

	add ix, de
	djnz .find_slot

	jr .done_drop


.drop_bomb:
	ld (ix+ALIEN.state), $0B
	ld a, h
	add a, $08
	ld (ix+ALIEN.y), a
	ld a, l
	add a, $04
	ld (ix+ALIEN.x), a

	ld hl, TEMPLATE_BOMBER_BOMB		; bomber bomb
	call copy_alien_template

.done_drop:
	pop ix

.check_hit:
	call alien_hits_player
	ret nz

	call decrease_energy

.score:
	call award_alien_score

become_explosion:
	ld a, (ix+ALIEN.x)
	ld (ix+ALIEN.param1), a
	ld a, (ix+ALIEN.y)
	ld (ix+ALIEN.param2), a
	ld (ix+ALIEN.state), $11
	ld (ix+ALIEN.x), $00
	ld (ix+ALIEN.width), $01
	ld (ix+ALIEN.height), $01
	ld (ix+ALIEN.mode), $06
	ld (ix+ALIEN.timer), $19

	ret
