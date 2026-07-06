; --- do_bomber -------------------------------------------------
; @done
; Spawn the bomber (state 16): clear the other aliens, play its
; sound, enter from the right (x $DC).
; In: ix = alien slot
do_bomber:
	ld a, (ix+ALIEN.spawn)
	and a
	ret nz

	ld a, $0A

	call play_sfx
	call kill_all_aliens

	ld (ix+ALIEN.state), $10
	ld (ix+ALIEN.x), $DC
	ld (ix+ALIEN.y), $00

	ld hl, TEMPLATE_BOMBER

	jp copy_alien_template
