; --- start_fall: begin falling (or flying if the Jackrabbit weapon is active) (@done)
start_fall:
	ld iy, (ACTIVE_SLOT)
	ld a, (iy+SLOT.WEAPON)
	cp $05
	jp z, start_fly
	ld a, (ix+ALIEN.param2)
	ld (ix+ALIEN.xvel), a
; entry point used by go_jump.
start_fall_0:
	ld (ix+ALIEN.param1), $01
	ld a, $06
	ld (PLAYER), a
	jp action_by_accum ;LB72D
