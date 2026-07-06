; --- move_mortar (alien state, vector 14) --------------------
; @done
; Mortar emplacement: randomly launch a shell (state 15, into
; ALIEN.1) toward the player; falls through to become_explosion.
; In: ix = alien
move_mortar:
	ld a, (ix+ALIEN.hp)
	and a
	jr z, .dead

	call generate_random

	and $25
	jr nz, .hit

	;ld a, (ix+$DA)
	ld a, (ix-ALIEN_LEN+ALIEN.state)
	and $3F
	jr nz, .hit

	push ix
	ld ix, ALIEN.1
	ld (ix+ALIEN.state), $0F
	ld a, (ix+ALIEN_LEN+ALIEN.x)
	ld (ix+ALIEN.x), a
	ld a, (ix+ALIEN_LEN+ALIEN.y)
	add a, $08
	ld (ix+ALIEN.y), a

	ld hl, TEMPLATE_MORTAR_SHELL
	call copy_alien_template

	pop ix

.hit:
	call alien_hits_player
	ret nz

	call decrease_energy

.dead:
	ld (ix+ALIEN.state), $00
	call award_alien_score

	jp become_explosion
