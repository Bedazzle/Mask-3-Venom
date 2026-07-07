; --- player_recoil: knock an alien back - set xvel from param2, enter recoil state (2), dispatch (@done)
player_recoil:
	ld a, (ix+ALIEN.param2)
	ld (ix+ALIEN.xvel), a
	ld (ix+ALIEN.timer), $02
	ld a, $02
	ld (ix+ALIEN.state), a
	jp action_by_accum
