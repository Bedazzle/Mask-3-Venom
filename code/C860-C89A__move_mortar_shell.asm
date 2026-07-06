; --- move_mortar_shell (alien state, vector 15) --------------
; @done
; Fast shell fired by move_mortar: travel left quickly (x -= 6)
; and expire at x < $34. In: ix = alien
move_mortar_shell:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .dead

	ld a, (ix+ALIEN.hit)
	and a
	jp nz, alien_killed

	ld a, (ix+ALIEN.x)
	sub $06
	ld (ix+ALIEN.x), a

	cp $34
	jr nc, .hit

	ld (ix+ALIEN.state), $40
	ld (ix+ALIEN.x), $00

	ret


.hit:
	call alien_hits_player
	ret nz

	call decrease_energy

.dead:
	call award_alien_score

	ld hl, VANISH_SMALL

	call start_vanish

	ld (ix+ALIEN.xvel), $FE
	ld (ix+ALIEN.yvel), $00

	ret
