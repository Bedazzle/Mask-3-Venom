; --- do_bomb ---------------------------------------------------
; @done
; Spawn a bomb (state 13, TEMPLATE_BOMB) after clearing the other
; aliens; re-arms via arm_alien if already spawned.
; In: ix = alien slot
do_bomb:
	ld a, (ix+ALIEN.spawn)
	and a
	jp nz, arm_alien

	call kill_all_aliens

	ld (ix+ALIEN.state), $0D	; procedure?
	ld (ix+ALIEN.x), $60
	ld (ix+ALIEN.y), $E2

	ld hl, TEMPLATE_BOMB

	call copy_alien_template

	ld (ix+ALIEN.yvel), $08
	ld (ix+ALIEN.param1), $00

	ret
