; --- do_harrier ------------------------------------------------
; @done
; Spawn the harrier mini-boss (state 8) unless one is already
; active (BOSS_ACTIVE); seeds its sweep counter (HARRIER_SWEEP).
; In: ix = alien slot
do_harrier:
	ld a, (BOSS_ACTIVE)
	and a
	ret nz

	ld (ix+ALIEN.state),8
	ld (ix+ALIEN.y), $32
	ld a, $FF
	ld (BOSS_ACTIVE), a
	ld hl, $0300
	ld (HARRIER_SWEEP), hl

	ld hl, TEMPLATE_HARRIER

	jp copy_alien_template
