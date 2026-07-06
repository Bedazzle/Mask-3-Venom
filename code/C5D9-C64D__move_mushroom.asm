; --- move_mushroom (alien state, vector 7) -------------------
; @done
; Mushroom: bounce around under xvel/yvel physics, reversing off
; walls; survives several player contacts before dying.
; In: ix = alien
move_mushroom:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .dead

	ld a, (ix+ALIEN.hit)
	and a
	jp nz, alien_killed

	ld a, (ix+ALIEN.anim)
	add a, (ix+ALIEN.param2)
	ld (ix+ALIEN.anim), a

	jr z, .flip_anim

	cp $03
	jr nz, .after_anim

.flip_anim:
	ld a, (ix+ALIEN.param2)
	neg
	ld (ix+ALIEN.param2), a
.after_anim:
	call alien_hits_player
	jr nz, .move

	call decrease_energy

	inc (ix+ALIEN.param1)
	ld a, (ix+ALIEN.param1)

	cp $05
	jr nz, .move
.dead:
	ld (ix+ALIEN.state), $00

	call award_alien_score

	ld hl, VANISH_MED	; mushroom disappearing by collision

	jp start_vanish

.move:
	call move_alien_x

	cp $40
	jr c, .despawn

	cp $B4
	jr nc, .bounce_left

	dec (ix+ALIEN.yvel)
	ret nz

	ld a, (ix+ALIEN.xvel)
	neg
	ld (ix+ALIEN.xvel), a

	call generate_random

	and $0F
	bit 7, (ix+ALIEN.xvel)
	jr z, .set_yvel

	add a, $06
.set_yvel:
	ld (ix+ALIEN.yvel), a

	ret
.despawn:
	ld (ix+ALIEN.state), $00

	ret
.bounce_left:
	ld (ix+ALIEN.xvel), $FE

	ret
