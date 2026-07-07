; --- finish_appear: materialise state (accum 12) - count the dissolve down, then stand (@done)
finish_appear:
	ld a, (ix+ALIEN.timer)
	and $0F
	jr nz, finish_appear_0
	ld hl, DISSOLVE
	dec (hl)
finish_appear_0:
	dec (ix+ALIEN.timer)
	ret nz
	ld (ix+ALIEN.state), $08
	xor a
	ld (DISSOLVE), a
	ret
